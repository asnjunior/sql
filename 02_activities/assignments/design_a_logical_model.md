# Assignment 1: Design a Logical Model

## Question 1
Create a logical model for a small bookstore. 📚

At the minimum it should have employee, order, sales, customer, and book entities (tables). Determine sensible column and table design based on what you know about these concepts. Keep it simple, but work out sensible relationships to keep tables reasonably sized. Include a date table. There are several tools online you can use, I'd recommend [_Draw.io_](https://www.drawio.com/) or [_LucidChart_](https://www.lucidchart.com/pages/).

## Question 2
We want to create employee shifts, splitting up the day into morning and evening. Add this to the ERD.

## Question 3
The store wants to keep customer addresses. Propose two architectures for the CUSTOMER_ADDRESS table, one that will retain changes, and another that will overwrite. Which is type 1, which is type 2?

_Hint, search type 1 vs type 2 slowly changing dimensions._

Please see question 3 diagram for the columns and relationships.

Type 1 overwrites and only retains the current address. For this type, the table is simpler and will only contain one address which is the current one. This will connect with the customer table on customer_id and relationship is 1 to 1.

Type 2 retains changes. This table will store more information as it keeps a historical record. It containts a start and end date for each address which will show when each address was used. This will connect with customer table on customer_id and relationship is 1 to many (customer is 1, customer_address is many).

Bonus: Are there privacy implications to this, why or why not?
```
Address data is personal data and needs protection. Understandably, the bookstore needs current address data for delivery purposes. But there is no need to store previous address data. Once personal data collected is no longer relevant, then this data doesnt need to be kept by the business. A good way to protect sensitive data is to not keep it in the first place if you dont need it.
```

## Question 4
Review the AdventureWorks Schema [here](https://i.stack.imgur.com/LMu4W.gif)

Highlight at least two differences between it and your ERD. Would you change anything in yours?
```
1. Separate order/sales information between header and details tables. This is probably the better way to organize order/sales data so there is less duplicated data. If all information are in one table, then the header information will duplicate for each of the detail information. And for a business where transactions will be of a big volume,  I would change my ERD and adapt the same strategy.    


2. Personal data separated between several tables - phone number, email address, address tables. This is probably for security purposes where not all sensitive information is stored in one table. This will also provide tha ability to limit access to only the specific sensitive data that is needed by giving access to only that one table and avoid a capture-all access. 

```

# Criteria

[Assignment Rubric](./assignment_rubric.md)

# Submission Information

🚨 **Please review our [Assignment Submission Guide](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md)** 🚨 for detailed instructions on how to format, branch, and submit your work. Following these guidelines is crucial for your submissions to be evaluated correctly.

### Submission Parameters:
* Submission Due Date: `September 28, 2024`
* The branch name for your repo should be: `model-design`
* What to submit for this assignment:
    * This markdown (design_a_logical_model.md) should be populated.
    * Two Entity-Relationship Diagrams (preferably in a pdf, jpeg, png format).
* What the pull request link should look like for this assignment: `https://github.com/<your_github_username>/sql/pull/<pr_id>`
    * Open a private window in your browser. Copy and paste the link to your pull request into the address bar. Make sure you can see your pull request properly. This helps the technical facilitator and learning support staff review your submission easily.

Checklist:
- [ ] Create a branch called `model-design`.
- [ ] Ensure that the repository is public.
- [ ] Review [the PR description guidelines](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md#guidelines-for-pull-request-descriptions) and adhere to them.
- [ ] Verify that the link is accessible in a private browser window.

If you encounter any difficulties or have questions, please don't hesitate to reach out to our team via our Slack at `#cohort-4-help`. Our Technical Facilitators and Learning Support staff are here to help you navigate any challenges.
