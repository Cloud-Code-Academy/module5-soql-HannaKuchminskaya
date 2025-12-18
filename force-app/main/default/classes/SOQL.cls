/**
 * The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
 * It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
 *
 * This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
 * a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
 * records, and manage data volume using the LIMIT keyword.
 *
 * Topics covered in this class include:
 * - Understanding the structure of a SOQL query.
 * - Crafting basic SELECT statements in SOQL.
 * - Applying filters using the WHERE clause in SOQL.
 * - Fetching related records using Relationship queries.
 * - Controlling the amount of data retrieved using the LIMIT keyword.
 *
 * Users of this class can expect to gain a solid understanding of SOQL in Apex and
 * be prepared to handle data retrieval tasks in Salesforce development.
 *
 * @author Hanna Kuchminskaya
 */

public with sharing class SOQL {
	/**
	 * Question 1
	 * Update/Uncomment the template code to create a method
	 * Returns all leads from Salesforce Org
	 * @return List of all leads with Id, LastName, Company, Phone, Email
	 * Update the corresponding test class and testGetAllLeads method to cover this method
	 */

	public static List<Lead> getAllLeads() {
		List<Lead> allLeads = [SELECT Id, LastName, Company, Phone, Email FROM Lead];
		return allLeads;
	}

	/**
	 * Question 2
	 * Update/Uncomment the template code to create a method
	 * Returns all contacts with first name of John.
	 * @return A list of Contact records.
	 * Update the corresponding test class and testGetContactsByFirstName method to cover this method
	 */

	public static List<Contact> getContactsByFirstName() {
		List<Contact> allJohnContacts = [SELECT Id, FirstName, LastName, Name FROM Contact WHERE FirstName= 'John'];
		return allJohnContacts;
	}

	/**
	 * Question 3
	 * Update/Uncomment the template code to create a method
	 * Returns the Contact Id for all contacts with last name of Smith or Jones
	 * @return A list of Contact Ids.
	 * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
	 */
	public static List<Id> getContactIdsByLastName() {
		List<Id> contactIds = new List<Id>();
		for (Contact c :[SELECT Id FROM Contact WHERE LastName in ('Jones', 'Smith')]){
			contactIds.add(c.Id);
		}
		return contactIds;
	}

	/**
	 * Question 4
	 * Update/Uncomment the template code to create a method
	 * Returns List of closed won opportunities for a specific Account.
	 * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A list of Opportunities with important opportunities fields
	 * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
	 */

	public static List<Opportunity> getClosedWonOpportunityForAccount (Id accountId) {
	List<Opportunity> closedWonOpportunities = [SELECT Id, Name, Amount, StageName, AccountId, CloseDate FROM Opportunity WHERE StageName= 'Closed Won' AND AccountId =:accountId];
	return closedWonOpportunities;
	}

	/**
	 * Question 5
	 * Update/Uncomment the template code to create a method
	 * Returns the total count of Account records.
	 * @return The Integer count of Account records.
	 * Update the corresponding test class and testGetAccountCount method to cover this method
	 */

	public static Integer GetAccountCount (){
	AggregateResult ar = [SELECT COUNT (Id) total FROM Account];
	return (Integer) ar.get('total');
	}

	/**
	 * Question 6
	 * Update/Uncomment the template code to create a method
	 * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
	 * @return A map of Task Ids to Task records.
	 * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
	 */

	public static Map<Id, Task> getTasksDueNextWeek (){
	List<Task> listOfTasks= [SELECT Id, Subject, ActivityDate  FROM Task WHERE ActivityDate = Next_N_DAYS:7];
	Map<Id, Task> mapOfTasks= new Map<Id, Task>();
	for (task t : listOfTasks){
		mapOfTasks.put(t.Id, t);
	}

	return mapOfTasks;
	}

	/**
	 * Question 7
	 * Update/Uncomment the template code to create a method
	 * Retrieves all Contacts that have a example.com domain in their Email.
	 * @return A list of Contact records.
	 * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
	public static List<Contact> getContactsByEmailDomain (){
	List<Contact> listOfContacts = [SELECT Id, Name, Email FROM Contact WHERE Email like '%example.com'];
	return listOfContacts;
	}

	/**
	 * Question 8
	 * Retrieves all Opportunities that have a specific keyword in their Name.
	 * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
	 * @param keyword The keyword to search for in the Opportunity Name.
	 * @return A list of Opportunity records.
	 */
	public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
		String search = '%'+ keyword +'%';
		List<Opportunity> listOfOpportunities = [SELECT Id, Name, Amount, StageName FROM Opportunity WHERE Name LIKE :search];
		return listOfOpportunities; 
	}

	/**
	 * Question 9
	 * Retrieves all Cases that Case Origin is not Web or Email or Blank
	 * @return A list of Case records.
	 */
	public static List<Case> getFilterCaseOrigins() {
		List<Case> listOfCases = [SELECT Id, Origin FROM Case WHERE Origin !=null AND (Origin NOT IN ('Email', 'Web'))];
		return listOfCases;
	}

	/**
	 * Question 10
	 * Update/Uncomment the template code to create a method
	 * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
	 * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
	 * @param leadSource The Lead Source to search for.
	 * @param keyword The keyword to search for in the Lead Title.
	 * @return A list of Lead records.
	 * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
	public static List<Lead> getLeadsBySourceOrTitle(string leadSource, string keyword) {
		string search = '%' + keyword + '%';
		List<Lead> leadsToReturn = [SELECT Id, LastName, Company, Phone, Email, Title, Name, LeadSource FROM Lead WHERE LeadSource =:leadSource OR Title LIKE :search];
		return leadsToReturn;
	}

	/**
	 * Question 11
	 * Returns the names of all Contacts associated with an Account.
	 * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A list of Contact LastName.
	 */
	public static List<String> getContactNamesByAccount(Id accountId) {
		// Create a list to hold the Contact LastNames
		List<String> contactLastNames = new List<String>();
		List<Contact> listOfContactsToReturn = [SELECT Id, LastName, AccountId FROM Contact WHERE AccountId =: accountId];
		for (Contact c : listOfContactsToReturn){
			contactLastNames.add(c.LastName);
		}
		return contactLastNames; 
	}

	/**
	 * Question 12
	 * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
	 * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for the found opportunities
	 * @param stage The Stage value to filter Opportunities.
	 * @return The total revenue.
	 */
	public static Decimal getTotalRevenueByStage(String stage) {
		// Use AggregateQuery to get the total revenue
		AggregateResult ar = [SELECT SUM (Amount) total from Opportunity WHERE StageName =:stage OR Amount >10000][0];

		return (decimal) ar.get('total'); 
	}

	/**
	 * Question 13
	 * Retrieves the first 10 Accounts ordered by Name.
	 * @return A list of the first 10 Accounts ordered by Name.
	 */
	public static List<Account> getFirstTenAccounts() {
		List<Account> accountsToReturn = [SELECT Id, Name FROM Account ORDER BY Name LIMIT 10];
		return accountsToReturn;
	}

	/**
	 * Question 14
	 * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
	 * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
	 */
	public static List<Opportunity> getHighValueOpportunities() {
		List<Opportunity> opportunitiesToReturn = [SELECT Id, Name, Amount, CloseDate FROM Opportunity WHERE Amount > 100000 ORDER BY CloseDate LIMIT 5];
		return opportunitiesToReturn;
	}

	/**
	 * Question 15
	 * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
	 * @return A list of Contacts
	 */
	public static List<Contact> getBirthdateContacts() {
		List<Contact> contactsToReturn = [SELECT Id, LastName, Birthdate FROM Contact ORDER BY Birthdate DESC LIMIT 3];
		return contactsToReturn;
	}

	/**
	 * Question 16
	 * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
	 * @return A list of Cases
	 */
	public static List<Case> getCasesWithStatus() {
		List<Case> casesToReturn = [SELECT Id, Status, CreatedDate FROM Case WHERE Status ='Open' ORDER BY CreatedDate LIMIT 10 OFFSET 5];
		return casesToReturn; 
	}

	/**
	 * Question 17
	 * Returns Set of Case Ids for a specific Account.
	 * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A set of Case Ids.
	 */
	public static Set<Id> getCaseIdsByAccount(Id accountId) {
		// Create a set to hold the Case Ids
		Set<Id> caseIdsToReturn = new Set<Id>();
		List<Case> casesByAccount = [SELECT Id, AccountId FROM Case WHERE AccountId =:accountId];
		for (case c : casesByAccount){
			caseIdsToReturn.add(c.Id);
		}
		return caseIdsToReturn; 
	}

	/**
	 * Question 18
	 * Return Map of Account Ids to Account Names Not in a specific Country.
	 * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
	 * @param country The country to filter Accounts.
	 * @return A map of Account Ids to Account Names.
	 */
	public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
		// Create a map to hold the Account Ids to Account Names
		Map<Id, String> accountIdsToNames = new Map<Id, String>();
		List<Account> relevantAccounts = [SELECT Id, Name, BillingCountry FROM Account WHERE BillingCountry NOT IN (:country)];
		for (account a : relevantAccounts) {
			accountIdsToNames.put(a.Id, a.Name);
		}

		return accountIdsToNames; 
	}

	/**
	 * Question 19
	 * Retrieves the Account Name for a given Contact.
	 * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
	 * @param contactId The Id of the Contact.
	 * @return The Account Name of the Contact.
	 */
	public static String getAccountNameForContact(String contactId) {
		List<Account> relevantAccount = [SELECT Id, Name FROM Account WHERE Id IN (SELECT AccountId FROM Contact WHERE Id =:contactId)];
		String result = (string) relevantAccount[0].get('Name');
		return result;
	}

	/**
	 * Question 20
	 * Returns single Account that has related opportunities in the same query
	 * Example: getAccountAndOpportunitiesFromAccountId('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
	 * @param accountId The ID of the Account.
	 * @return An Account record with related Opportunities.
	 */
	public static Account getAccountAndOpportunitiesFromAccountId(Id accountId) {
		List<Account> relevantAccountWithOpportunities = [SELECT Id, Name, (Select Id, Name FROM Opportunities) FROM Account WHERE Id =:accountId];
		return relevantAccountWithOpportunities[0]; 
	}

	/**
	 * Question 21
	 * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
	 * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
	 * @param Account Id
	 * @return List of contacts with the same Mailing State as the Account Billing State
	 */
	public static List<Contact> getAccountsWithContactsByState(Id accountId) {
		// Query the Account
		List<Account> acct = [SELECT Id, Name, BillingState FROM Account WHERE Id=:accountId];

		// Store the Account's BillingState
		string billingState = (string) acct[0].get('BillingState');
		

		// Query the Contacts
		List<Contact> contactsToReturn = [SELECT Id, MailingState FROM Contact WHERE MailingState =:billingState];
		return contactsToReturn; 
	}

	/**
	 * Question 22
	 * Extracts email domains from them leads, then finds Accounts with matching website domains
	 * If Lead Email = test@test.com return account with website = www.test.com
	 * Example: findAccountsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
	 * @param A set of Lead Ids.
	 * @return A list of Accounts with matching email domains.
	 */
	public static List<Account> findAccountsByLeadEmailDomains(Set<Id> leadIds) {
		// Query the Leads
		List<Lead> listOfLeads = [SELECT Id, Email FROM Lead Where Id IN :leadIds];
		Set<String> emailDomains = new Set<String>();
		for (lead l : listOfLeads) {
			if(l.email!=null && l.email.contains('@')){
			emailDomains.add(l.email.substringAfter('@').toLowerCase());
			}
		}

		List<Account> accountsWithWebsites = [SELECT Id, Name, Website FROM Account WHERE Website!=NULL];
		List<Account> accountsToReturn = new List<Account> ();
		For (account acct :accountsWithWebsites) {
			string website = acct.Website.toLowerCase();
			for (string domain : emailDomains) {
				if (website.contains(domain)) {
					accountsToReturn.add(acct);
				}
			}
		}

		return accountsToReturn;
	}

	/**
	 * Question 23
	 * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
	 * Adds a randomized number between 1 to 3 to the quantity of each line item.
	 * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
	 * @param Original Opportunity Id
	 * @param List of cloned Opportunity Ids
	 */
	public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
		// Query the original Opportunity Line Items
		List<OpportunityLineItem> originalLineItems = [SELECT Id, OpportunityId, Quantity, UnitPrice, PricebookEntryId FROM OpportunityLineItem WHERE OpportunityId =:origOppId];
		// Create a list to hold the new line items
		List<OpportunityLineItem> opiToInsert = new List<OpportunityLineItem>();
		// Generate a random number between 1 and 3
	
		// Loop through each cloned Opportunity Id
		for (Id clonedOppId : cloneOppIds) {
		// Loop through each original line item
		for (OpportunityLineItem opi : originalLineItems)
		{
			OpportunityLineItem clonedOpi = opi.clone(false, false, false, false);
			Integer randomNumber = (Integer) (Math.random() * (3-1+1)) + 1;
			clonedOpi.Quantity= opi.Quantity + randomNumber;
			clonedOpi.OpportunityId = clonedOppId;
			opiToInsert.add(clonedOpi);

		}

		}
		insert opiToInsert;

	}

	/**
	 * Question 24
	 * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
	 * @return A list of filtered Opportunity
	 */
	public static List<Opportunity> getOpportunityDetailsForClosedWon() {
		List<Opportunity> opportunititesToReturn = [SELECT Name, AccountId, Primary_Contact__c, Account.Name, Owner.Name FROM Opportunity WHERE StageName ='Closed Won'];
		return opportunititesToReturn;
	}

	/**
	 * Question 25
	 * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to the Contact on the associated Account with the alphabetically first first name.
	 * Example: if there are two Contacts on the Account, "Billy" and "Abby," the 'Primary_Contact__c' will be set to "Abby."
	 */
	public static void setPrimaryContact() {
		//Use the getOpportunityDetailsForClosedWon() method to get the Opportunities
		List<Opportunity> listOfOpportunitites = getOpportunityDetailsForClosedWon();

		// Create a set of Account Ids from the Opportunities
		Set<Id> accountIds = new Set<Id>();
		for (opportunity opp : listOfOpportunitites){
			accountIds.add(opp.AccountId);
		}
		// Query the Contacts
		List<Contact> listOfContacts = [SELECT Id, FirstName, Name, AccountId FROM Contact WHERE AccountId IN :accountIds ORDER BY FirstName DESC];

		// Loop through each Contact and add the Account Id and Contact to the map
		Map<Id, Contact> mapOfContactsAndAccounts = new Map<Id, Contact> ();
		For (Contact c : listOfContacts) {
			if (!mapOfContactsAndAccounts.containsKey(c.AccountId)){
			mapOfContactsAndAccounts.put(c.AccountId, c);
			}
		}
		// Loop through each Opportunity
		// Update the Opportunity primary contact from accountToContactMap
		for(opportunity Opp : listOfOpportunitites){
			Contact primaryContact = mapOfContactsAndAccounts.get(opp.AccountId);
			Opp.Primary_Contact__c = primaryContact.Id;
		}

		// Update the Opportunities
		update listOfOpportunitites;
	}
}
