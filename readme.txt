make a police information system
technical requirements: ASP.NET WEBFORM, C#, MYSQL 8 using Visual studio 2019
Bootstrap adminlte3 design, admin dashboard 1
forms: must have required field validator, textbox placeholder, 

public master page
home page - welcome to Police information system "add tagline", with 3 column show image and description, View Crime report, View police officers, Crime details
Officer page - list of officer with position,rank, fullname, profile image upload, admin can add,edit,delete
Complaints page - citizen can report complaints
police clearance page - citizen apply police clearance, admin can manage issued police clearance with auto sequence ctrl no generate number
login page

admin masterpage
manage complaints (categorize complaint: crime, gun shoot, riot, etc.)
manage police clearance
manage officers
manage user
home dashboard count complaints (this month, prev monthresolve,pending, etc.), issued police clearance (this month, prev month, all), officers



// Project: Police Information System
// Platform: ASP.NET WebForms, C#, MySQL 8
// IDE: Visual Studio 2019
// Frontend: Bootstrap + AdminLTE 3

/********** Master Pages **********/

// 1. Public Master Page (Site.Master)
- Navigation Menu:
  - Home
  - View Crime Reports
  - View Police Officers
  - Crime Details
  - Login

// 2. Admin Master Page (Admin.Master)
- Sidebar Menu:
  - Dashboard
  - Manage Complaints
  - Manage Police Clearance
  - Manage Officers
  - Manage Users
  - Logout

/********** Pages **********/

// Home.aspx
- Header: "Welcome to Police Information System" + Tagline
- Content: 3 Bootstrap columns
  - Image + Description (View Crime Reports)
  - Image + Description (View Police Officers)
  - Image + Description (Crime Details)

// Officer.aspx
- GridView: List officers (position, rank, fullname, profile image)
- Admin Panel: Add/Edit/Delete (profile image upload)
- Validators: RequiredFieldValidator on all input fields
- FileUpload control for profile image

// Complaints.aspx
- Form: Citizen inputs complaint details
  - Fields: Full Name, Contact, Description, Category (dropdown)
  - Category: Crime, Gun Shoot, Riot, etc.
- Validators: RequiredFieldValidator, placeholders in TextBoxes
- Auto-set status to "Pending"

// PoliceClearance.aspx
- Citizen Form:
  - Fields: Full Name, DOB, Address, Valid ID, Purpose
  - Validators + placeholders
- Admin Panel:
  - List requests
  - Approve/Reject button
  - Auto-generate control number (e.g., PCLR-2025-0001)

// Login.aspx
- Role-based login (Admin/Citizen)
- Redirect to correct master page

/********** Admin Dashboard (AdminHome.aspx) **********/

- Panels/Cards:
  - Total Complaints This Month
  - Complaints Last Month
  - Resolved / Pending Complaints
  - Police Clearance Issued This Month / Last Month / All Time
  - Total Active Officers

/********** Technical Setup **********/

// Database: MySQL 8
- Tables: Users, Officers, Complaints, PoliceClearance, Categories

// Controls:
- Use GridView for lists
- Use RequiredFieldValidator, ValidationSummary
- AdminLTE3 templates for layout
- Use Bootstrap Cards for dashboard statistics

// Authentication:
- Session-based login
- Role-check per page (Admin/Citizen)

// File Upload:
- Store images in /Uploads
- Save image filename/path in DB

// Control Number Generation (Police Clearance):
- Format: PCLR-[Year]-[4-digit-sequence]
- Auto-increment from last record

// Tools:
- Visual Studio 2019
- MySQL Connector/NET
- Web.config connection string to MySQL

// Add-ons:
- jQuery for interactivity
- SweetAlert2 for alerts (optional)

// Security:
- Input validation
- Parameterized queries to prevent SQL Injection


