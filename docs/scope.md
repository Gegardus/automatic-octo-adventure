## Aligned SUV Platform Scope

### Development Stack

The development stack for this project includes the following technologies and services:

- **Backend Framework:** Ruby on Rails
- **Database:** PostgreSQL
- **File Storage:** Azure
- **Hosting:** Heroku
- **Email Communication:** SendGrid
- **Frontend:** Vanilla JavaScript, Turbo, and Stimulus

### Environments

- Staging
- Production

### Scope

The scope of work for the SUV Platform encompasses the following key features and
functionalities organized by user roles:

#### Anonymous

- Access the Homepage, which includes a configurable carousel of images managed by admins.
- Log in to their accounts.
- Initiate the password recovery process, with an email sent to the customer.
- Submit inquiries or set up meetings, with email notifications sent to the customer and all admins.
- Complete a Captcha challenge to prevent spam and bot inquiries.
- Accept invitations to create accounts after inquiry approval.

#### Admins

##### User Management
- Change their own passwords.
- Update their profile details.

##### Platform Management
- Deactivate users (both admins and applicants) as needed.
- Invite other admins to the platform, with email notifications sent to the invited admin.

##### Inquiries Management
- View user inquiries.
- Approve or decline inquiries, with email notifications sent to the customer.

##### Application Management
- View applications submitted by applicants.
- Access printable versions of applications for all steps.
- Invite applicants to initiate the application process, possibly with the option to skip sections. Email notifications are sent to the customer.
- Assign mentors to applications after the questionnaire stage, with potential mentor-customer contact. Email notifications are sent to the customer.
- Add and remove notes to/from application steps.
- Allow viewing all files associated with a specific application.
- List applications requiring attention and approve them.
- List meet-with-mentor requests.
- Invite applicants to collaborate on applications.
- Access and manage resources in the Resource Vault.
- View help requests and step skip requests (approve or decline).
- Download step specific template csv
- Allow upload of completed csv

##### Resource Management
- View Resource Vault.
- Add resources to the vault, which may include links, files or embedded youtube content.
- Edit existing resources in the vault.

##### Request Management
- View help requests from applicants.
- View and respond to step skip requests (approve or decline).

#### Applicants

##### Account Management
- Reset their passwords.
- Change their passwords.
- Update their profile details.

##### Application Workflow
- Navigate through multiple application steps, each comprising sections.
- View progress bars indicating completion status for each step and the overall application.
- Complete quick assessments specific to each application, answering specified questions.
- Attach files when required within application steps.
- Utilize checkboxes to request external help (details to be clarified).
- Unlock the PR Networking Events section after successfully completing the marketing section (additional details about events and sign-up process needed).
- Configure which step is not available until the previous step is complete.
- Receive a certificate upon successfully completing all application steps.

##### Application Management
- Submit help requests for assistance during the application process.
- Request to skip a particular application step.
- Edit completed sections, with a version history maintained.
- Request sessions with mentors.

#### Mentors
- View applications that they are mentoring
