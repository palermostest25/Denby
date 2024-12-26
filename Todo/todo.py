import sys
import json
from PyQt5.QtWidgets import (
    QApplication,
    QMainWindow,
    QVBoxLayout,
    QHBoxLayout,
    QLineEdit,
    QPushButton,
    QListWidget,
    QStackedWidget,
    QWidget,
    QLabel,
    QComboBox,
    QListWidgetItem,
    QMessageBox,
)
from PyQt5.QtCore import Qt


class TodoApp(QMainWindow):
    def __init__(self):
        super().__init__()

        self.setWindowTitle("Modern To-Do List")
        self.resize(1000, 700)

        self.data = {"users": {"Guest": {"lists": {"My Day": []}}}}
        self.current_user = "Guest"
        self.current_list = "My Day"

        self.init_ui()
        self.load_data()

    def init_ui(self):
        # Main layout
        main_layout = QHBoxLayout()

        # Sidebar
        self.sidebar = QVBoxLayout()
        self.sidebar.setContentsMargins(0, 0, 0, 0)

        # User Dropdown
        self.user_dropdown = QComboBox()
        self.user_dropdown.addItems(self.data["users"].keys())
        self.user_dropdown.currentTextChanged.connect(self.change_user)
        self.sidebar.addWidget(QLabel("Users"))
        self.sidebar.addWidget(self.user_dropdown)

        # Add User Button
        add_user_btn = QPushButton("Add User")
        add_user_btn.clicked.connect(self.add_user)
        self.sidebar.addWidget(add_user_btn)

        # Lists Section
        self.sidebar.addWidget(QLabel("Lists"))
        self.list_widget = QListWidget()
        self.list_widget.itemClicked.connect(self.change_list)
        self.sidebar.addWidget(self.list_widget)

        # Add List Button
        add_list_btn = QPushButton("Add List")
        add_list_btn.clicked.connect(self.add_list)
        self.sidebar.addWidget(add_list_btn)

        self.sidebar.addStretch()

        # Main Area
        self.main_area = QVBoxLayout()

        # Current List Title
        self.list_title = QLabel(self.current_list)
        self.list_title.setAlignment(Qt.AlignCenter)
        self.main_area.addWidget(self.list_title)

        # Task Input
        task_input_layout = QHBoxLayout()
        self.task_input = QLineEdit()
        self.task_input.setPlaceholderText("Add a new task...")
        add_task_btn = QPushButton("Add Task")
        add_task_btn.clicked.connect(self.add_task)
        task_input_layout.addWidget(self.task_input)
        task_input_layout.addWidget(add_task_btn)
        self.main_area.addLayout(task_input_layout)

        # Task List
        self.task_list_widget = QListWidget()
        self.main_area.addWidget(self.task_list_widget)

        # Combine layouts
        container = QWidget()
        layout = QHBoxLayout(container)
        layout.addLayout(self.sidebar, 2)
        layout.addLayout(self.main_area, 6)
        self.setCentralWidget(container)

        # Load initial lists and tasks
        self.refresh_sidebar()
        self.refresh_task_list()

    def add_user(self):
        user_name, ok = QMessageBox.getText(self, "Add User", "Enter a new user name:")
        if ok and user_name.strip():
            if user_name not in self.data["users"]:
                self.data["users"][user_name] = {"lists": {"My Day": []}}
                self.user_dropdown.addItem(user_name)
                QMessageBox.information(self, "Success", f"User '{user_name}' added successfully!")
            else:
                QMessageBox.warning(self, "Error", f"User '{user_name}' already exists!")

    def change_user(self, user_name):
        self.current_user = user_name
        self.current_list = list(self.data["users"][self.current_user]["lists"].keys())[0]
        self.refresh_sidebar()
        self.refresh_task_list()

    def add_list(self):
        list_name, ok = QMessageBox.getText(self, "Add List", "Enter a new list name:")
        if ok and list_name.strip():
            if list_name not in self.data["users"][self.current_user]["lists"]:
                self.data["users"][self.current_user]["lists"][list_name] = []
                self.refresh_sidebar()
                QMessageBox.information(self, "Success", f"List '{list_name}' added successfully!")
            else:
                QMessageBox.warning(self, "Error", f"List '{list_name}' already exists!")

    def change_list(self, item):
        self.current_list = item.text()
        self.list_title.setText(self.current_list)
        self.refresh_task_list()

    def add_task(self):
        task_text = self.task_input.text().strip()
        if task_text:
            task = {"text": task_text, "completed": False}
            self.data["users"][self.current_user]["lists"][self.current_list].append(task)
            self.refresh_task_list()
            self.task_input.clear()

    def toggle_task(self, item):
        task_index = self.task_list_widget.row(item)
        task = self.data["users"][self.current_user]["lists"][self.current_list][task_index]
        task["completed"] = not task["completed"]
        self.refresh_task_list()

    def refresh_sidebar(self):
        self.list_widget.clear()
        for list_name in self.data["users"][self.current_user]["lists"]:
            self.list_widget.addItem(list_name)

    def refresh_task_list(self):
        self.task_list_widget.clear()
        tasks = self.data["users"][self.current_user]["lists"][self.current_list]
        for task in tasks:
            task_item = QListWidgetItem(task["text"])
            task_item.setCheckState(Qt.Checked if task["completed"] else Qt.Unchecked)
            task_item.setFlags(task_item.flags() | Qt.ItemIsUserCheckable)
            self.task_list_widget.addItem(task_item)
            task_item.setData(Qt.UserRole, task)

        self.task_list_widget.itemChanged.connect(self.handle_task_change)

    def handle_task_change(self, item):
        task_index = self.task_list_widget.row(item)
        task = self.data["users"][self.current_user]["lists"][self.current_list][task_index]
        task["completed"] = item.checkState() == Qt.Checked

    def save_data(self):
        with open("todo_data.json", "w") as file:
            json.dump(self.data, file, indent=4)

    def load_data(self):
        try:
            with open("todo_data.json", "r") as file:
                self.data = json.load(file)
                self.refresh_sidebar()
        except FileNotFoundError:
            pass

    def closeEvent(self, event):
        self.save_data()
        event.accept()


if __name__ == "__main__":
    app = QApplication(sys.argv)
    todo_app = TodoApp()
    todo_app.show()
    sys.exit(app.exec_())
