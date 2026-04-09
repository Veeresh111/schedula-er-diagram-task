## The Main Parts of the System

### Part 1: Patient and User Management

This section stores information about people who use the system. We have three types of people:

- Patients: People who come to see doctors
- Doctors: Healthcare professionals who treat patients
- Admin staff: People who manage the system

Each person has a basic profile with their name, email, phone number, and password.

### Part 2: Doctor and Healthcare Providers

Doctors have special information stored about them like:

- Their specialty (like cardiology or pediatrics)
- Their qualifications and medical degrees
- How many years they have been practicing
- Their medical license number
- How much they charge for a consultation
- Their rating based on patient reviews
- A brief description about their background

### Part 3: Scheduling and Appointments

This is how doctors set their availability and patients book time slots:

- Doctors tell the system when they are available (for example, Monday to Friday, 9 AM to 5 PM)
- The system automatically creates time slots (like 9:00-9:30, 9:30-10:00, etc.)
- Patients can see available slots and book appointments
- The system prevents double bookings (two patients cannot book the same time slot)

### Part 4: Relationships and Groups

The system tracks family members and groups:

- Family connections: A patient can link to their spouse, children, parents, or siblings
- Medical groups: Doctors can create groups for patients with similar conditions (like a diabetes group or heart disease group)
- Membership: The system tracks which patients belong to which groups

---

## Understanding the Database Tables

### Users Table - The Foundation

This is the base table that stores everyone in the system.

Information stored:
- User ID (unique identifier)
- Full name
- Phone number
- Email address
- Password (encrypted for security)
- User type (patient, doctor, or admin)
- Whether account is active or inactive
- When the account was created
- When the account was last updated

### Patients Table - Patient Details

Extends the user information with medical and personal details.

Information stored:
- Patient ID
- Link to their user account
- Date of birth
- Age
- Gender
- City and state where they live
- Postal code
- Medical history summary
- Known allergies
- Blood group
- Chronic conditions (ongoing health issues)
- Emergency contact person
- Creation and update timestamps

### Doctors Table - Doctor Credentials

Stores professional information about doctors.

Information stored:
- Doctor ID
- Link to their user account
- Medical specialty
- Qualifications and degrees
- Years of experience
- Medical license number
- Consultation fee
- Average rating from patients
- Professional biography

### Clinics Table - Healthcare Facilities

Information about physical locations where patients can be seen.

Information stored:
- Clinic ID
- Clinic name
- Physical location
- Full address
- Phone number
- Operating hours
- When the record was created

### Availability Table - Doctor Schedules

Defines when doctors are available to see patients.

Information stored:
- Availability ID
- Doctor ID
- Day of the week (Monday, Tuesday, etc.)
- Start time (like 9:00 AM)
- End time (like 5:00 PM)
- How many minutes each appointment takes
- Creation and update timestamps

For example: Doctor Smith works Monday, Wednesday, and Friday from 9 AM to 5 PM, with 30-minute appointment slots.

### Slots Table - Individual Time Slots

This table holds all the individual appointment time slots.

Information stored:
- Slot ID
- Link to availability template
- Doctor ID
- Patient ID (if someone booked it)
- Specific date
- Start time
- Whether the slot is booked
- Who booked it (user ID)
- Creation and update timestamps

### Appointments Table - Core Appointment Records

The main record of an appointment between a patient and doctor.

Information stored:
- Appointment ID
- Patient user ID
- Doctor ID
- Slot ID
- Start time
- End time
- Whether it is booked
- Whether it is completed
- Type of appointment (consultation, follow-up, check-up)
- Status (scheduled, completed, cancelled, no-show)
- Patient notes (symptoms or concerns)
- Doctor notes (observations and findings)
- Creation and update timestamps

### Appointment Consultations - Medical Outcomes

Records what happened during the appointment.

Information stored:
- Consultation ID
- Appointment ID
- Doctor ID
- Patient ID
- Diagnosis
- Treatment plan
- Medications prescribed
- Whether follow-up is needed
- Days until follow-up
- Creation and update timestamps

### Schedule History - Audit Trail

Every change to an appointment is logged here.

Information stored:
- History ID
- Appointment ID
- What action happened (created, updated, cancelled, rescheduled)
- What the old value was
- What the new value is
- Who made the change (user ID)
- Reason for the change
- When the change was made

### Family Mapping - Family Relationships

Links family members together in the system.

Information stored:
- Mapping ID
- Main patient user ID
- Related patient ID
- Relationship type (spouse, child, parent, sibling)
- Whether this is the primary contact
- When the relationship was added

### Groups Table - Patient Groups

Doctors can organize patients into medical groups.

Information stored:
- Group ID
- Doctor ID who created the group
- Group name
- Creation and update timestamps

### Group Members - Group Membership

Tracks which patients are in which groups.

Information stored:
- Member ID
- Group ID
- Patient ID
- When the patient joined
- Creation timestamp

### Payments Table - Financial Records

Tracks all money transactions.

Information stored:
- Payment ID
- Appointment ID
- Patient user ID
- Doctor ID
- Amount paid
- Currency type
- Payment method (credit card, debit card, bank transfer, etc.)
- Transaction ID from payment system
- Payment status (pending, completed, failed, refunded)
- When payment was made
- When record was created

### Feedback Table - Patient Satisfaction

Collects patient reviews about their experience.

Information stored:
- Feedback ID
- Appointment ID
- Doctor ID
- Clinic rating (1-5 stars)
- Doctor rating (1-5 stars)
- Waiting experience rating (1-5 stars)
- Customer comments
- Creation and update timestamps

---

## How the System Works - Step by Step

### Step 1: Patient Registration

When a new patient signs up:

1. Patient enters their information in the app (name, email, phone, password)
2. System checks if this person already exists by looking at:
   - Same email address
   - Same phone number
   - Same name and date of birth together
   - Similar sounding names (using sound matching)
3. If someone with same info is found, system says "You already have an account, please login"
4. If it is a new person, system creates the account
5. Password is encrypted for security
6. Information is saved in the Users table and Patients table
7. Patient gets a confirmation email

### Step 2: Doctor Sets Their Schedule

When a doctor configures availability:

1. Doctor logs in to their dashboard
2. Doctor tells system which days they work (Monday, Wednesday, Friday)
3. Doctor enters start time (9:00 AM) and end time (5:00 PM)
4. Doctor sets appointment length (like 30 minutes)
5. System saves this schedule template
6. System automatically generates individual time slots for the next 90 days
7. For example: Monday 9:00-9:30, Monday 9:30-10:00, etc.
8. All slots start as available (not booked)
9. System repeats this automatically every day to keep 90 days of slots ready

### Step 3: Patient Books an Appointment

When a patient wants to schedule a visit:

1. Patient searches for a doctor by specialty or name
2. System shows available slots for that doctor
3. Patient sees doctor information (specialty, rating, fees)
4. Patient picks a date and time
5. System locks that slot to prevent another patient from booking it at the same time
6. System creates an appointment record
7. System marks the slot as booked
8. Doctor gets notified that a new appointment was booked
9. Patient gets confirmation with appointment details
10. System creates an audit log entry recording that the appointment was created

### Step 4: Appointment Happens

On the day of the appointment:

1. Before appointment time, patient and doctor get reminders
2. When patient arrives, clinic marks them as checked in
3. Doctor examines patient and takes notes
4. Doctor records diagnosis and treatment plan
5. Doctor prescribes medications if needed
6. Doctor decides if follow-up is needed
7. Appointment is marked as completed
8. Invoice is created for payment
9. Patient is asked to give feedback and rating
10. Full details are saved in consultation record
11. Everything is logged in the audit trail

### Step 5: Finding and Merging Duplicate Patients

This is the most important part. When the same person accidentally registers twice:

**Detection Phase - System Finds Duplicates**

The system automatically scans for duplicates every 6 hours. It checks for:

- Exact match: Same email or same phone number (100% match)
- Fuzzy name match: Similar names with same birthdate (95% match)
- Phone and age match: Same phone with birthdate within one year (80% match)
- Sound alike names: Names that sound the same but spelled differently (75% match)

For example:
- Patient A: John Doe, john@email.com, 9876543210
- Patient B: Jon Doe, jon@email.com, 9876543210
- System confidence: 95% - This is likely the same person (typo in email)

**Admin Review Phase - Human Verification**

System alerts administrator with:

- Side by side comparison of both records
- Match confidence score
- All appointments for each patient
- All medical records
- All payments
- Family relationships

Admin can:
- Confirm these are duplicates
- Say they are different people
- Ask for more information

**Merge Phase - Combining Records**

Once confirmed as duplicates, system merges them:

1. System picks one patient as primary (usually the one with more complete information)
2. System makes a backup copy of both records (in case something goes wrong)
3. System starts a transaction (all or nothing operation)
4. Medical history from secondary patient is added to primary patient
5. All appointments from secondary patient are reassigned to primary patient
6. All payments from secondary patient are reassigned to primary patient
7. All family relationships from secondary patient are reassigned to primary patient
8. Secondary account is marked as inactive
9. Full log entry is created recording the merge
10. Both patients get email notifications about the merge
11. All changes are saved at once (atomic transaction)

**After Merge**

- Primary patient has all combined records
- Secondary patient account is inactive but not deleted
- If someone tries to login with secondary email, they are redirected to primary email
- Complete history is kept for legal and audit purposes

---

## Important Concepts Explained Simply

### Transactions - All or Nothing

When multiple changes need to happen together, the system uses transactions. Either all changes succeed together, or if something goes wrong, all changes are undone. This prevents corrupted data.

Example: When booking an appointment:
- Create appointment record
- Mark slot as booked
- Create notification
- Create audit log entry

All four must succeed. If one fails, all four are undone.

### Indexes - Speed Up Searches

Indexes are like a book's index. Instead of reading every page to find a topic, you look in the index and jump to the right pages. The system has indexes for:

- Patient names (for searching)
- Email addresses (for finding duplicates)
- Phone numbers (for finding duplicates)
- Appointment dates (for showing calendar)
- Doctor IDs (for showing their appointments)

### Constraints - Rules for Data Quality

The system enforces rules:

- Email must have @ sign
- Phone number must be 10 digits
- Start time must be before end time
- Status must be one of: scheduled, completed, cancelled, no-show
- Every appointment must have a patient and doctor

### Audit Logs - Complete History

Every action is recorded with:
- What happened (created, updated, cancelled)
- What changed (old value and new value)
- Who did it (user ID)
- When it happened (timestamp)
- Why it happened (reason if provided)

This is required for legal compliance and for investigating problems.

### Soft Deletes - Never Really Delete

Instead of deleting records, the system marks them as inactive. This way:
- Data is never lost
- History is preserved
- Compliance requirements are met
- If needed, records can be reactivated

---

## Security Measures

The system protects patient information:

1. Passwords are encrypted and never stored in plain text
2. Sensitive information is encrypted when stored
3. Only authorized people can see patient data
4. Doctors can only see their own patients
5. Patients can only see their own information
6. All access is logged
7. Data is encrypted when sent over internet
8. Regular backups are made
9. System is compliant with healthcare privacy laws

---

## Performance Features

To keep the system fast:

1. Important columns are indexed (like email, phone, date)
2. Frequently accessed data is cached
3. Large tables are split by date or patient ID
4. Appointments table is organized by date for fast queries
5. Duplicate detection uses efficient algorithms

---

## When Something Goes Wrong

If there is a problem:

1. All changes in a transaction are rolled back (undone)
2. Database stays in good condition
3. Patient data is never corrupted
4. Previous backups can restore everything

---

## Real World Example

Let me show you what happens when John Doe accidentally registers twice:

**Before Merge**

Patient ID 1: John Doe, john.doe@gmail.com, 9876543210
- Appointments: 3 (all with Dr. Smith)
- Payments: 1500 rupees

Patient ID 2: Jon Doe, jon.doe@gmail.com, 9876543210 (typo in email)
- Appointments: 2 (all with Dr. Johnson)
- Payments: 1000 rupees

**System Detects It**

Both have:
- Same phone number
- Same birthdate
- Similar names (one is typo)
- System confidence: 95%

**Admin Reviews**

Admin sees both records side by side and confirms they are the same person.

**System Merges**

1. Patient 1 becomes primary (more recent activity)
2. Patient 2 data is backed up
3. Patient 2's 2 appointments are reassigned to Patient 1
4. Patient 2's payment of 1000 rupees is added to Patient 1's records
5. Patient 2 account is deactivated
6. Complete merge log is created

**After Merge**

Patient ID 1: John Doe, john.doe@gmail.com, 9876543210
- Appointments: 5 (3 from Dr. Smith, 2 from Dr. Johnson)
- Payments: 2500 rupees
- Status: ACTIVE

Patient ID 2: Jon Doe
- Status: INACTIVE (merged into Patient 1)

**Notification Sent**

John gets email: "Your accounts have been merged. Please use john.doe@gmail.com to login going forward."

## Final review-ready submission for Task 1
