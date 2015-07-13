namespace java com.boxalino.dataintelligence.api.thrift
namespace php com.boxalino.dataintelligence.api.thrift

/**
 * This enumeration defines the possible exception states returned by Boxalino Data Intelligence Thrift API
 */
enum DataIntelligenceServiceExceptionNumber {
	/**
	 * general case of exception (no special detailed provided)
	 */
	GENERAL_EXCEPTION = 1,
	/**
	 * the provided credentials to retrieve an authentication token are not valid (wrong username, password or both)
	 */
	INVALID_CREDENTIALS = 2,
	/**
	 * your user has been blocked (but it doesn't necessarily mean your account has been blocked)
	 */
	BLOCKED_USER = 3,
	/**
	 * your account has been blocked, you must contact Boxalino (<a href="mailto:support@boxalino.com">support@boxalino.com</a>) to know the reasons of this blocking.
	 */
	BLOCKED_ACCOUNT = 4,
	/**
	 * the provided authentication token is invalid (wrong, or no more valid), you should get a new one by calling the GetAuthentication service.
	 */
	INVALID_AUTHENTICATION_TOKEN = 5,
	/**
	 * specific to the service function UpdatePassword: means that the new password is not correct (should be at least 8 characters long and not contain any punctuation)
	 */
	INVALID_NEW_PASSWORD = 6,
	/**
	 * the provided configuration object contains a configuration version number which doesn't exists or cannot be accessed
	 */
	INVALID_CONFIGURATION_VERSION = 7,
	/**
	 * the provided XML data source is not correct (see documentation of the data source XML format)
	 */
	INVALID_DATASOURCE = 8,
	/**
	 * the provided content to be changed (updated, deleted, etc.) is defined with a content id which doesn't exists
	 */
	NON_EXISTING_CONTENT_ID = 9,
	/**
	 * the provided content id to be created already exists
	 */
	ALREADY_EXISTING_CONTENT_ID = 10,
	/**
	 * the provided content id doesn't not match the requested format (less than 50 alphanumeric characters without any punctuation or accent)
	 */
	INVALID_CONTENT_ID = 11,
	/**
	 * the provided content data are not correctly set
	 */
	INVALID_CONTENT = 12,
	/**
	 * one of the provided languages has not been defined for this account
	 */
	INVALID_LANGUAGE = 13,
        /**
         * the provided file identifier has been already used
         */
	DUPLICATED_FILE_ID = 14,
        /**
         * the provided list of columns is empty
         */
	EMPTY_COLUMNS_LIST = 15,
        /**
         * the provided file identifier was not found
         */
	NON_EXISTING_FILE = 16,
        /**
         * the provided time range is incorrect (start timestamp is higher than the end one)
         */
	INVALID_RANGE = 17,
	
	/**
	* the provided report request contains some invalid parameters settings (missing settings, conflicting settings, etc.)
	*/
	INVALID_REPORT_REQUEST = 18
}

/**
 * This exception is raised by all the BoxalinoDataIntelligence service function in case of a problem
 */
exception DataIntelligenceServiceException {
	/**
	 * indicate the exception number based on the enumeration DataIntelligenceServiceExceptionNumber
	 */
	1: required DataIntelligenceServiceExceptionNumber exceptionNumber
	/**
	 * a textual message to explain the error conditions more in details
	 */
	2: required string message
}

/**
 * This structure defines the parameters to be send to receive an authentication token (required by all the other services)
 */
struct AuthenticationRequest {
	/**
	 * the name of your account (as provided to you by Boxalino team, if you don't have an account, contact <a href="mailto:support@boxalino.com">support@boxalino.com</a>)
	 */
	1: required string account,
	/**
	 * usually the same value as account (but can be different for users with smaller rights, if you don't have a username, contact <a href="mailto:support@boxalino.com">support@boxalino.com</a>)
	 */
	2: required string username,
	/**
	 * as provided by Boxalino, or according to the last password update you have set. If you lost your password, contact <a href="mailto:support@boxalino.com">support@boxalino.com</a>)
	 */
	3: required string password
}

/**
 * This structure defines the authentication object (to pass as authentication proof to all function and services)
 */
struct Authentication {
	/**
	 * the return authentication token is a string valid for one hour
	 */
	1: required string authenticationToken
}

/**
 * This enumeration defines the version type. All contents are versioned, normally, you want to change the current development version and then, when finished, publish it (so it becomes the new production version and a new development version is created), but it is also possible to access the production version directly
 */
enum ConfigurationVersionType {
	/**
	 * this is the normal case, as you want to retrieve the current dev version of your account configuration and not touch the production one
	 */
	CURRENT_DEVELOPMENT_VERSION = 1,
	/**
	 * this should only be used in rare cases where you want to recuperate information from the production configuration, but be careful in changing this version as it will immediately affect your production processes!
	 */
	CURRENT_PRODUCTION_VERSION = 2,
}

/**
 * This structure defines a configuration version of your account. It must be provided to all functions accessing / updating or removing information from your account configuration
 */
struct ConfigurationVersion {
	/**
	 * an internal number identifying the configuration version
	 */
	1: required i16 configurationVersionNumber,
	/**
	 * an internal number identifying the configuration version
	 */
	2: optional map<string, string> systemParameters
}

/**
 * This structure defines a configuration difference (somethin which has changed between two configuration versions)
 */
struct ConfigurationDifference {
	/**
	 * the type of content which has changed (e.g.: 'field')
	 */
	1: required string contentType,
	/**
	 * the content id which has changed (e.g: a field id)
	 */
	2: required string contentId,
	/**
	 * the content parameter which has changed (e.g.: a field type)
	 */
	3: required string parameterName,
	/**
	 * the string encoded value of the content parameter value of the source configuration
	 */
	4: required string contentSource,
	/**
	 * the string encoded value of the content parameter value of the destination configuration
	 */
	5: required string contentDestination
}

/**
 * This structure defines a data Field. A field covers any type of data property (customer property, product properties, etc.). Fields are global for all data sources, but can be used only for special data sources and ignored for others. This grants that the properties are always ready to unify values from different sources, but they don't have to.
 */
struct Field {
	/**
	 * a unique id which should not contain any punctuation, only non-accentuated alphabetic and numeric characters and should not be longer than 50 characters
	 */
	1: required string fieldId
}

/**
 * This structure defines a data ProcessTask. A process task covers any kind of process task to be executed by the system.
 */
struct ProcessTask {
	/**
	 * a unique id which should not contain any punctuation, only non-accentuated alphabetic and numeric characters and should not be longer than 50 characters
	 */
	1: required string processTaskId
}

/**
 * This structure defines a data synchronisation process task. It is used to get the data from external systems and process it.
 */
struct DataSyncProcessTask {
	/**
	 * a unique id which should not contain any punctuation, only non-accentuated alphabetic and numeric characters and should not be longer than 50 characters
	 */
	1: required string processTaskId,
	/**
	 * list of data sources which should be used to get data from
	 */
	2: required list<DataSource> inputs,
	/**
	 * list of data exports which should be used to push the data into
	 */
	3: required list<DataExport> outputs,
	/**
	 * defines if it is dev version of the task process
	 */
	4: required bool dev = false,
	/**
	 * defines if this particular task process is differential
	 */
	5: required bool delta = false
}

/**
 * This structure defines a task Scheduling. A scheduling is a collection of process tasks to be executed one after the other by the system.
 */
struct Scheduling {
	/**
	 * a unique id which should not contain any punctuation, only non-accentuated alphabetic and numeric characters and should not be longer than 50 characters
	 */
	1: required string schedulingId
}

/**
 * This structure defines a task RecommendationBlock. A RecommendationBlock is a visual block of recommendation for one page of your web-site (product detail page, basket page, etc.) you can have several recommendation blocks on the same page.
 */
struct RecommendationBlock {
	/**
	 * a unique id which should not contain any punctuation, only non-accentuated alphabetic and numeric characters and should not be longer than 50 characters
	 */
	1: required string recommendationBlockId
}

/**
 * This structure defines a data source. Data source is used to get the data from external systems into DI.
 */
struct DataSource {
	/**
	 * a unique id which should not contain any punctuation, only non-accentuated alphabetic and numeric characters and should not be longer than 50 characters
	 */
	1: required string dataSourceId
}

/**
 * This structure defines a data source type used to get the data from reference csv files defined with the API
 */
struct ReferenceCSVDataSource {
	/**
	 * a unique id which should not contain any punctuation, only non-accentuated alphabetic and numeric characters and should not be longer than 50 characters
	 */
	1: required string dataSourceId,
	/**
	 * identifier of the data source which will be extended by this data source
	 */
	2: required string extendedDataSourceId
}

/**
 * This structure defines a data export type used to push processed data into
 */
struct DataExport {
	/**
	 * a unique id which should not contain any punctuation, only non-accentuated alphabetic and numeric characters and should not be longer than 50 characters
	 */
	1: required string dataExportId
}

enum Language {
	GERMAN = 1,
	FRENCH = 2,
	ENGLISH = 3,
	ITALIAN = 4,
	SPANISH = 5,
	DUTCH = 6,
	PORTUGUESE = 7,
	SWEDISH = 8,
	ARABIC = 9,
	RUSSIAN = 10,
	JAPANESE = 11,
	KOREAN = 12,
	TURKISH = 13,
	VIETNAMESE = 14,
	POLISH = 15,
	UKRAINIAN = 16,
	CHINESE_MANDARIN = 17,
	OTHER = 100
}

/**
 * This structure defines a data EmailCampaign. A campaign is a parameter holder for a campaign execution. It should not change at each sending, but the parameters (especially cmpid) can and should be changed before any new campaign sending (if new campid applies). For the case of trigger campaigns, the cmpid (and other parameters) usually don't change, but for the case of newsletter campaigns, very often each sending has a different id. In this case, the cmpid must be updated (and the dev configuration should be published) every time.
 */
struct EmailCampaign {
	/**
	 * a unique id which should not contain any punctuation, only non-accentuated alphabetic and numeric characters and should not be longer than 50 characters
	 */
	1: required string emailCampaignId
	/**
	 * the running campaign id which is often specific to the running of a specific newsletter e-mail (should be changed every time before sending a blast e-mail with the new value (don't forget to publish the dev configuration)
	 */
	2: required string cmpid
	/**
	 * the dateTime at which the campaign will be sent (cannot be in the past when the campaign is ran, an exception will be then raised). Must have the format YYYY-MM-DD HH:MM:SS
	 */
	3: required string dateTime
	/**
	 * a localized value of the base url to use for e-mail links
	 */
	4: required map<Language,string> baseUrl
	/**
	 * a localized value of the subject line of the e-mail (default, can be overwritten by a specific choice variant localized parameters with parameter name 'subject')
	 */
	5: required map<Language,string> subject
	/**
	 * a localized value of the first sentence of the e-mail (default, can be overwritten by a specific choice variant localized parameters with parameter name 'firstSentence')
	 */
	6: required map<Language,string> firstSentence
	/**
	 * a localized value of the legal notices to be included in the e-mail (default, can be extended by a specific choice variant localized parameters with parameter name 'legals')
	 */
	7: required map<Language,string> legals
}

/**
 * This structure defines a data Choice.
 */
struct Choice {
	/**
	 * a unique id which should not contain any punctuation, only non-accentuated alphabetic and numeric characters and should not be longer than 50 characters
	 */
	1: required string choiceId
}

/**
 * This structure defines a data Choice variant
 */
struct ChoiceVariant {
	/**
	 * a unique id which should not contain any punctuation, only non-accentuated alphabetic and numeric characters and should not be longer than 50 characters
	 */
	1: required string choiceVariantId,
	/**
	 * the choice id of the choice which this variant is associated to
	 */
	2: required string choiceId,
	/**
	 * a list of tags this variant is connected to
	 */
	3: required list<string> tags,
	/**
	 * a list of non-localized parameters this variant is connected to (for example, to overwrite the campaign properties, keys should have the same name as the campaign parameter name)
	 */
	4: required map<string, list<string>> simpleParameters,
	/**
	 * a list of localized parameters this variant is connected to (for example, to overwrite the campaign properties, keys should have the same name as the campaign parameter name)
	 */
	5: required map<string, list<map<Language,string>>> localizedParemeters
}

/**
 * This enumeration defines the possible process task execution statuses type (to check the completion of an execution of  process task and its result)
 */
enum ProcessTaskExecutionStatusType {
	/**
	 * The process was not started yet
	 */
	WAITING = 1,
	/**
	 * The process has started and is currently running
	 */
	STARTED = 2,
	/**
	 * The process has finished successfully
	 */
	FINISHED_SUCCESS = 3,
	/**
	 * The process has finished, but with some warnings
	 */
	FINISHED_WITH_WARNINGS = 4,
	/**
	 * The process has failed
	 */
	FAILED = 5,
	/**
	 * The process has been aborted
	 */
	ABORTED = 6,
}

/**
 * This structure defines a process task execution status (the status of execution of a process task) with its type and a textual message
 */
struct ProcessTaskExecutionStatus {
	/**
	 * the status type of this execution of the process task
	 */
	1: required ProcessTaskExecutionStatusType statusType,
	/**
	 * some additonal information about the type (can be empty, used to explain errors and warnings)
	 */
	2: required string information
}

/**
 * This structure defines the execution parameters of a process task
 */
struct ProcessTaskExecutionParameters {
	/**
	 * the process task id to execute
	 */
	1: required string processTaskId,
	/**
	 * should the process run with development data that should not to be published into the production environment
	 */
	2: required bool development,
	/**
	 * is the process a differential process that adds or updates a part of the existing data, otherwise the new data will replace any existing data completely
	 */
	3: required bool delta,
	/**
	 * if another similar process is already running, the forceStart flag will make the new one run, otherwise, the execution will be aborted
	 */
	4: required bool forceStart
}

/**
 * This enumeration defines possible types of columns which can be used in a reference CSV file
 */
enum CSVFileColumnType {
	/**
	 * text string encoded using UTF-8 encoding
	 */
	STRING = 1,
	/**
	 * signed 64-bit integer
	 */
	INTEGER = 2,
	/**
	 * floating point number
	 */
	DOUBLE = 3,
	/**
	 * textual representation of the date and time in the format YYYY-MM-DD HH:MM:SS
	 */
	DATETIME = 4,
	/**
	 * textual representation of the date in the format YYYY-MM-DD
	 */
	DATE = 5,
	/**
	 * textual representation of the time in the format HH:MM:SS
	 */
	TIME = 6,
	/**
	 * numerical representation of the date and time as an unsigned 32-bit integer, counting the seconds since the start of the UNIX epoch
	 */
	UNIX_TIMESTAMP = 7
}

/**
 * This structure defines a reference CSV file descriptor with the identifier and schema
 */
struct ReferenceCSVFileDescriptor {
	/**
	 * identifier of the csv file, needs to be unique per account
	 */
	1: required string fileId,
	/**
	 * key-value map of the file columns, where key is a name of the column and value is a column's type
	 */
	2: required map<string, CSVFileColumnType> fileColumns,
	/**
	 * internal hash used for csv file upload - this property is set by the API and cannot be changed
	 */
	3: optional string fileHash
}

/**
 * This structure defines a schedulings execution parameters. A scheduling is a collection of process tasks to be executed one after the other by the system.
 */
struct SchedulingExecutionParameters {
	/**
	 * the scheduling id to execute
	 */
	1: required string schedulingId,
	/**
	 * should the process tasks run with development version data
	 */
	2: required bool development,
	/**
	 * are the process tasks incremental processes (or full)
	 */
	3: required bool delta,
	/**
	 * if similar process tasks are already running, the forceStart will make the new ones run, otherwise, the execution will be aborted
	 */
	4: required bool forceStart
}

/**
 * This structure defines a time range
 */
struct TimeRange {
	/**
	 * UNIX timestamp of a lower boundary of the range
	 */
	1: required i64 from,
	/**
	 * UNIX timestamp of a upper boundary of the range
	 */
	2: required i64 to
}

/**
 * This enumeration defines possible granularities used in time ranges
 */
enum TimeRangePrecision {
	/**
	 * daily precision
	 */
	DAY = 1,
	/**
	 * weekly precision
	 */
	WEEK = 2,
	/**
	 * monthly precision
	 */
	MONTH = 3,
	/**
	 * quarterly precision
	 */
	QUARTER = 4,
	/**
	 * yearly precision
	 */
	YEAR = 5,
	/**
	 * return all data for provided date range as one
	 */
	ALL = 6
}

/**
 * This structure defines a time range value of the KPI
 */
struct TimeRangeValue {
	/**
	 * used time range
	 */
	1: required TimeRange range,
	/**
	 * KPI value for this particular range
	 */
	2: required double value
}

/**
 * This enumeration defines possible report metric types
 */
enum ReportMetricType {
	/**
	 * number of unique visitors (or user)
	 */
	VISITORS = 1,
	/**
	 * number of visits (or session)
	 */
	VISITS = 2,
	/**
	 * number of landing page bounces
	 */
	BOUNCES = 3,
	/**
	 * BOUNCES / VISITS
	 */
	BOUNCE_RATE = 4,
	/**
	 * number of page views
	 */
	PAGE_VIEWS = 5,
	/**
	 * PAGE_VIEWS / VISITS
	 */
	PAGE_VIEWS_PER_VISIT = 6,
	/**
	 * average time of visits
	 */
	AVERAGE_TIME_ON_SITE = 7,
	/**
	 * number of product views
	 */
	PRODUCT_VIEWS = 8,
	/**
	 * PRODUCT_VIEWS / VISITS
	 */
	PRODUCT_VIEWS_PER_VISIT = 9,
	/**
	 * number of visits having at least one product view
	 */
	VISITS_WITH_PRODUCT_VIEWS = 10,
	/**
	 * VISITS_WITH_PRODUCT_VIEWS / VISITS
	 */
	VISITS_WITH_PRODUCT_VIEWS_RATE = 11,
	/**
	 * number of in-site searches
	 */
	SEARCHES = 12,
	/**
	 * SEARCHES / VISITS
	 */
	SEARCHES_PER_VISIT = 13,
	/**
	 * number of visits having at least one search
	 */
	VISITS_WITH_SEARCHES = 14,
	/**
	 * VISITS_WITH_SEARCHES / VISITS
	 */
	VISITS_WITH_SEARCHES_RATE = 15,
	/**
	 * number of goals (require identifier to be provided with the choice identifier)
	 */
	GOALS = 16,
	/**
	 * GOALS / VISITS (require identifier to be provided with the choice identifier)
	 */
	GOALS_PER_VISIT = 17,
	/**
	 * number of visits having at least one goal (require identifier to be provided with the choice identifier)
	 */
	VISITS_WITH_GOALS = 18,
	/**
	 * VISITS_WITH_GOALS / VISITS (require identifier to be provided with the choice identifier)
	 */
	VISITS_WITH_GOALS_RATE = 19,
	/**
	 * number of transactions
	 */
	TRANSACTIONS = 20,
	/**
	 * TRANSACTIONS / VISITS
	 */
	TRANSACTIONS_PER_VISIT = 21,
	/**
	 * number of visits having at least one transaction
	 */
	VISITS_WITH_TRANSACTIONS = 22,
	/**
	 * VISITS_WITH_TRANSACTIONS / VISITS 
	 */
	VISITS_WITH_TRANSACTIONS_RATE = 23,
	/**
	 * transaction turnover 
	 * N.B.: will return zero for all cases which cannot be mapped to any transaction
	 */
	TRANSACTIONS_TURNOVER = 28,
	/**
	 * sum of the transaction parameter values (require identifier to be provided with the transaction parameter name)
	 * N.B.: will return zero for all cases which cannot be mapped to any transaction
	 */
	TRANSACTIONS_PARAMETER_SUM = 29,
	/**
	 * count of the total number of transaction items (one product with quantity one is one item)
	 */
	TRANSACTIONS_QUANTITY = 30,
	/**
	 * number of add-to-basket events
	 */
	ADD_TO_BASKETS = 24,
	/**
	 * ADD_TO_BASKET / VISITS
	 */
	ADD_TO_BASKETS_PER_VISIT = 25,
	/**
	 * number of visits having at least one add to basket event
	 */
	VISITS_WITH_ADD_TO_BASKETS = 26,
	/**
	 * VISITS_WITH_ADD_TO_BASKETS / VISITS 
	 */
	VISITS_WITH_ADD_TO_BASKETS_RATE = 27,
	/**
	 * number of time the event has occurred
	 */
	EVENT_COUNT = 40,
	/**
	 * number of display of a choice
	 */
	CHOICE_DISPLAYS = 100,
	/**
	 * number of visits having at least one choice display
	 */
	VISITS_WITH_CHOICE_DISPLAYS = 101,
	/**
	 * number of product views event related to product displayed in a choice display
	 * if a ReportDimension is on the product id, then only for this product id
	 */
	PRODUCT_VIEWS_FROM_CHOICE_DISPLAY = 110,
	/**
	 * number of visits having at least one product views event related to product displayed in a choice display
	 * if a ReportDimension is on the product id, then only for this product id
	 * if a ReportDimension is on a Choice, then only for this choice
	 * if a ReportDimension is on a ChoiceVariant, then only for this choice variant
	 */
	VISITS_WITH_PRODUCT_VIEWS_FROM_CHOICE_DISPLAY = 111,
	/**
	 * number of transactions related to product displayed in a choice display
	 * if a ReportDimension is on the product id, then only for this product id
	 * if a ReportDimension is on a Choice, then only for this choice
	 * if a ReportDimension is on a ChoiceVariant, then only for this choice variant
	 */
	TRANSACTIONS_FROM_CHOICE_DISPLAY = 112,
	/**
	 * sum of transaction property value of transactions related to product displayed in a choice display
	 * if a ReportDimension is on the product id, then only for this product id
	 * if a ReportDimension is on a Choice, then only for this choice
	 * if a ReportDimension is on a ChoiceVariant, then only for this choice variant
	 */
	TRANSACTIONS_PARAMETER_SUM_FROM_CHOICE_DISPLAY = 113,
	/**
	 * number of visits having at least one transaction event related to product displayed in a choice display
	 * if a ReportDimension is on the product id, then only for this product id
	 * if a ReportDimension is on a Choice, then only for this choice
	 * if a ReportDimension is on a ChoiceVariant, then only for this choice variant
	 */
	VISITS_WITH_TRANSACTIONS_FROM_CHOICE_DISPLAY = 114,
	/**
	 * number of add to baskets related to product displayed in a choice display
	 * if a ReportDimension is on the product id, then only for this product id
	 * if a ReportDimension is on a Choice, then only for this choice
	 * if a ReportDimension is on a ChoiceVariant, then only for this choice variant
	 */
	ADD_TO_BASKETS_FROM_CHOICE_DISPLAY = 115,
	/**
	 * number of visits having at least one add to basket related to product displayed in a choice display
	 * if a ReportDimension is on the product id, then only for this product id
	 * if a ReportDimension is on a Choice, then only for this choice
	 * if a ReportDimension is on a ChoiceVariant, then only for this choice variant
	 */
	VISITS_WITH_ADD_TO_BASKETS_FROM_CHOICE_DISPLAY = 116,
	/**
	 * number of goals related to product displayed in a choice display
	 * (require identifier to be provided with the choice identifier)
	 * (will only work if a product identifier is provided with the goal)
	 * if a ReportDimension is on the product id, then only for this product id
	 * if a ReportDimension is on a Choice, then only for this choice
	 * if a ReportDimension is on a ChoiceVariant, then only for this choice variant
	 */
	GOALS_FROM_CHOICE_DISPLAY = 117,
	/**
	 * number of visits having at least goal related to product displayed in a choice display
	 * (require identifier to be provided with the choice identifier)
	 * (will only work if a product identifier is provided with the goal)
	 * if a ReportDimension is on the product id, then only for this product id
	 * if a ReportDimension is on a Choice, then only for this choice
	 * if a ReportDimension is on a ChoiceVariant, then only for this choice variant
	 */
	VISITS_WITH_GOALS_FROM_CHOICE_DISPLAY = 118
}

/**
 * This structure defines a report metric (kpi) which can be standard or custom wiht an identifier (e.g.: for goals)
 */
struct ReportMetric {
	/**
	 * the type of metric
	 */
	1: required ReportMetricType type,
	/**
	 * optional, for the ReportMetricType requiring it (e.g.: goal) the identifier the metric
	 */
	2: optional string identifier
}

/**
 * This enumeration defines possible report dimension types
 */
enum ReportDimensionType {
	/**
	 * is the visitor a new visitor or a returning visitor
	 */
	NEW_VISITOR = 1,
	/**
	 * the detected country of the visitor (NULL if none detected)
	 */
	GEO_COUNTRY = 2,
	/**
	 * the detected zip code of the visitor (NULL if none detected)
	 */
	GEO_ZIP = 3,
	/**
	 * the detected subdivision (Kanton for Switzerland) of the visitor (NULL if none detected)
	 */
	GEO_SUBDIVISION = 4,
	/**
	 * the detected city of the visitor (NULL if none detected)
	 */
	GEO_CITY = 4,
	/**
	 * the user agent name (most common values: IE,Mobile Safari,Chrome,Firefox,Safari,Android browser,Chrome Mobile,Java,IE Mobile,Opera,Mobile Firefox)
	 */
	BROWSER_NAME = 5,
	/**
	 * the user agent version
	 */
	BROWSER_VERSION = 5,
	/**
	 * the user agent operating system (most common values: Windows 7,iOS 7,Windows 8.1,iOS 8,Android 4.4 KitKat,OS X 10.9 Mavericks,Windows 8,Windows XP,Windows Vista,Android 4.2 Jelly Bean)
	 */
	OPERATING_SYSTEM = 6,
	/**
	 * the user agent device category (most common values: Personal computer,Smartphone,Tablet,Other)
	 */
	DEVICE_CATEGORY = 7,
	/**
	 * the AdWords Creative (requires that the AdWords ValueTrack is passed on the url parameter as "&creative={creative}"
	 */
	ADWORDS_CREATIVE = 8,
	/**
	 * the AdWords Keyword (requires that the AdWords ValueTrack is passed on the url parameter as "&keyword={keyword}"
	 */
	ADWORDS_KEYWORD = 9,
	/**
	 * the search queries done in the web-site
	 */
	ONSITE_SEARCH_QUERY = 15,
	/**
	 * the different hours of the day (from "0" to "24")
	 */
	HOUR_OF_DAY = 20,
	/**
	 * the different moments of the day ("22-6", "6-10", "10-12", "12-14", "14-17", "17-19", "19-22")
	 */
	MOMENT_OF_DAY = 21,
	/**
	 * the different days of the week ("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
	 */
	DAY_OF_WEEK = 22,
	/**
	 * the different moments of the week ("Monday-Friday", "Saturday-Sunday")
	 */
	MOMENT_OF_WEEK = 23,
	/**
	 * the timestamp at the beginning of the session (one dimension per session)
	 */
	SESSION_START_TIMESTAMP = 24,
	/**
	 * the session id (as provided by the tracker)
	 */
	SESSION_ID = 25,
	/**
	 * the session id (internal id of Boxalino)
	 */
	INTERNAL_SESSION_ID = 26,
	/**
	 * the visitor id (as provided by the tracker)
	 */
	VISITOR_ID = 27,
	/**
	 * the visitor id (internal id of Boxalino)
	 */
	INTERNAL_VISITOR_ID = 28,
	/**
	 * the different values of a URL parameter (require identifier to be provided with url parameter name)
	 */
	URL_PARAMETER = 50,
	/**
	 * the different values of a transaction property (requires identifier to be provided with the transaction property name)
	 * N.B.: a connection to the transaction property must be available (e.g.: For visit&visitor-based reporting, like ChoiceReport, will only work for the visits/visitors with a transaction)
	 */
	TRANSACTION_PROPERTY = 100,
	/**
	 * the different values of a customer property (requires identifier to be provided with the customer property name)
	 * N.B.: a connection to the transaction property must be available (e.g.: For visit&visitor-based reporting, like ChoiceReport, will only work for the visits/visitors with a login or other ways to link the customer id to the visitor id)
	 */
	CUSTOMER_PROPERTY = 150,
	/**
	 * the different values of a product property (requires identifier to be provided with the product property name)
	 * N.B.: a connection to the transaction property must be available (e.g.: For visit&visitor-based reporting, like ChoiceReport, will only work for the visits/visitors with a product purchased)
	 */
	PURCHASED_PRODUCT_PROPERTY = 200,
	/**
	 * the different values of a product property (requires identifier to be provided with the product property name)
	 * N.B.: a connection to the product property must be available (e.g.: For visit&visitor-based reporting, like ChoiceReport, will only work for the visits/visitors with a product displayed in the choice variant)
	 */
	PRODUCT_PROPERTY = 201,
	/**
	 * the different possible choice ids (requires identifier to be provided with the choiceId as indicated in the structure Choice)
	 * N.B.: a connection to the product property must be available (e.g.: For visit&visitor-based reporting, like ChoiceReport, will only work for the visits/visitors with a product displayed in the choice variant)
	 */
	CHOICE = 300,
	/**
	 * the different possible choice variant ids (requires identifier to be provided with the choiceVariantIdId as indicated in the structure ChoiceVariant)
	 * N.B.: a connection to the product property must be available (e.g.: For visit&visitor-based reporting, like ChoiceReport, will only work for the visits/visitors with a product displayed in the choice variant)
	 */
	CHOICE_VARIANT = 301,
	/**
	 * The index of the returned time serie (starting at zero) related to this result (requires identifier to be provided with the cohort id field requested)
	* N.B.: the ReportDimensionValue value will indicate the index as a number 0->n-1, n-1 being the last time range of the cohort report
	 */
	COHORT_INDEX = 1000
}

/**
 * This structure defines a report dimension (segmentation) which can be standard or custom with an identifier (e.g.: for url parameters)
 */
struct ReportDimension {
	/**
	 * the type of metric
	 */
	1: required ReportDimensionType type,
	/**
	 * optional, for the ReportDimensionType requiring it (e.g.: goal) the identifier the metric
	 */
	2: optional string identifier,
	/**
	 * optional, an additional parameter
	 * Use cases:
	 * - for hierarchical product properties for the type PURCHASED_PRODUCT_PROPERTY (e.g.: "categories") provide the level of depth to consider: "0" : first level, "1" : second level, ...
	 * in the response, this parameter will be replaced with the category id (label will provide the bread crumb as value : "cat1 >> cat2 >> cat3", but the id of this cat3 will be provided in the param1)
	 */
	3: optional string param1,
	/**
	 * optional, an additional parameter (planned, but not used until now)
	 */
	4: optional string param2,
	/**
	 * optional, an additional parameter (planned, but not used until now)
	 */
	5: optional string param3
}

/**
* the possible condition operators to be used in a condition target
*/
enum  ConditionOperator {
	/**
	* when cast as a String, does the substring provided in the ConditionTarget value match exactly the source string?
	*/
	IS = 1,
	/**
	* when cast as a String, does the substring provided in the ConditionTarget value NOT match exactly the source string?
	*/
	IS_NOT = 2,
	/**
	* when cast as a number, is the number provided in the source number greater (but not equal or smaller) than the ConditionTarget value?
	*/
	IS_GREATER = 3,
	/**
	* when cast as a number, is the number provided in the source number greater or equal (but not smaller) than the ConditionTarget value?
	*/
	IS_GREATER_OR_EQUAL = 4,
	/**
	* when cast as a number, is the number provided in the source number smaller (but not equal or greater) than the ConditionTarget value?
	*/
	IS_SMALLER = 5,
	/**
	* when cast as a number, is the number provided in the source number smaller or equal (but not greater) than the ConditionTarget value?
	*/
	IS_SMALLER_OR_EQUAL = 6,
	/**
	* when cast as a String, is the substring provided in the ConditionTarget value contained in the source string?
	*/
	CONTAINS = 7,
	/**
	* when cast as a String, is the substring provided in the ConditionTarget value NOT contained in the source string?
	*/
	DOES_NOT_CONTAIN = 8,
	/**
	* when cast as a String, does the substring provided in the ConditionTarget value match the first characters of the source string?
	*/
	STARTS_WITH = 9,
	/**
	* when cast as a String, does the substring provided in the ConditionTarget value NOT match the first characters of the source string?
	*/
	DOES_NOT_START_WITH = 10,
	/**
	* when cast as a String, does the substring provided in the ConditionTarget value match the last characters of the source string?
	*/
	ENDS_WITH = 11,
	/**
	* when cast as a String, does the substring provided in the ConditionTarget value NOT match the last characters of the source string?
	*/
	DOES_NOT_END_WITH = 12
}

/**
* this structure defines the operator and values required for a condition to be true
* (example: condition "is", value : "123"
*/
struct ConditionTarget {
	/**
	* the condition target operator ("is", "is not", "greater than", ...)
	*/
	1: required ConditionOperator operator,
	/**
	* the condition value (will be cast in the proper format, so "123" == 123)
	*/
	2: required string value
}

/**
* this structure defines a dimension condition, corresponding to a list of ConditionTargets for a given dimension
*/
struct DimensionCondition {
	/**
	* the report dimension
	*/
	1: required ReportDimension dimension,
	/**
	* the list of condition targets to be matched
	*/
	2: required list<ConditionTarget> conditionTargets
}

/**
* this structure defines a metric condition, corresponding to a list of ConditionTargets for a given metric
*/
struct MetricCondition {
	/**
	* the report metric
	*/
	1: required ReportMetric metric,
	/**
	* the list of condition targets to be matched
	*/
	2: required list<ConditionTarget> conditionTargets
}

/**
 * this structure defines a report filter (set of and clauses), all of which must be true
 */
struct ReportFilter {
	/**
	* the dimension filters
	*/
	1: required list<DimensionCondition> dimensionConditions,
	/**
	* the metric filters
	*/
	2: required list<MetricCondition> metricConditions
}

/**
 * This structure defines an optimization report request
 */
struct ChoiceReportRequest {
	/**
	 * the choice source id (identifying the system being the source of the choices, if you don't have a choice source id already, please contact support@boxalino.com) (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)
	 */
	1: string choiceSourceId,
	/**
	 * the choice to analyse (e.g.: each landing page is a choice and has several variant potentially, even if only one)
	 */
	2: required Choice choice,
	/**
	 * the metrics to evaluate report (e.g.: kpis to return)
	 */
	3: required list<ReportMetric> metrics,
	/**
	 * an optional choice variants to use as filters (only return the results for these choicevariants)
	 */
	4: optional list<string> choiceVariantIds,
	/**
	 * an optional flag to indicate that the results should display not only the choice variant, but which recommendation strategies have been used for each choice variant (only applicable if the choice is a recommendation choice)
	 */
	5: optional bool returnRecommendationStrategies,
	/**
	 * an optional dimension for the report (for segmentation), while groups are different for each type of reporting, the dimension are normally standard (visitor country, device, ...)
	 */
	6: optional ReportDimension dimension,
	/**
	 * an optional list of metrics to limit the report to only the cases where at least one of the metrics of the list was reached (e.g.: if focusedMetrics are goal-X and goal-Y, then the Metric Transactions will not be returned for all the visits, but only for the visits who did reach goal-X or goal-Y at least once)
	 */
	7: optional list<ReportMetric> funnelMetrics,
	/**
	 * the metrics to use for sorting the results
	 */
	8: optional list<ReportMetric> sortBys,
	/**
	 * a required date range for the reporting response (precision is only managed per day)
	 */
	9: required TimeRange range,
	/**
	 * a required date range precision if the results should be aggregated per week or month, overall or return for each day
	 */
	10: required TimeRangePrecision precision,
	/**
	 * an optional starting index (e.g.: if the maximum number of results was exceeded and a second page needs to be displayed). First index is 0.
	 */
	11: optional i16 startIndex,
	/**
	 * an required number of maximum number of results (one result is one source of date rage data in of values for all kpis)
	 */
	12: required i16 maxResults
}

/** 
 * This structure defines a map key (signature) of a choice report result (indication about what this result is about)
 * The ChoiceReport object contains a map with the results. For each key (i.e.: result group) the system returns a list of report metrics (kpis) and value for each date range requested.
 * These keys are, in the case of a ChoiceReport defined by the choice variant and, possibly a specific dimension value of the choice variant.
 * It is possible that there is no value for the dimension, but then there must be a value for the choiceVariant.
 * It is possible that there is no value for the choiceVariant, but then there must be a value for the choiceVariant.
 * It is only possibly that the recommendationStrategy has a value if a choiceVariant value is also provided.
 * It is possible that the 3 variables (choiceVariant, recommendationStrategy and dimensionValue) are all set.
 * Even if allowed by the fact that all of the variables are optional, it is not possible that none of the variables are set.
 */
struct ChoiceReportResult {
	/**
	* the choice variant of the choice
	*/
	1: optional string choiceVariantId,
	/**
	* optional: indicate a specific recommendation strategy which provided the result (only returned for recommendation choices when the flag returnRecommendationStrategies is true)
	*/
	2: optional string recommendationStrategy,
	/**
	 * an optional dimension value (in case a dimension has been requested for segmentation)
	 */
	3: optional string dimensionValue,	
	/**
	* the report result values
	*/
	4: required ReportResultValues values
}


/**
 * This enumeration defines possible report result value key types.
 * For each report result groups, the system returns a map of ReportResultValues object (i.e.:a map of report metric (kpi) with their values) for each time range. 
 * These time ranges can be of different types (absolute defining exactly form a specific moment to another, or relative, starting at 0 for the first key, for cohort analysis).
 */
enum ReportResultTimeRangeType {
	/**
	 * an absolute time range (defines the datetime start and end of the reporting values for this key)
	 */
	REAL_TIME = 1,
	/**
	 * returns the start and end date time based on timestamp 0 being the beginning of the report (if cohort per day: first value: 0->3600*24, second value: 3600*24->3600*24*2, ...)
	 */
	COHORT = 2
}

/** 
 * This structure defines a metric value association
 */
struct ReportMetricValue {
	/**
	* the metric
	*/
	1: required ReportMetric metric,
	/**
	* the metric value
	*/
	2: required double value
}

/** 
 * This structure defines a dimension value association
 */
struct ReportDimensionValue {
	/**
	* the dimension
	*/
	1: required ReportDimension dimension,
	/**
	* the dimension value
	*/
	2: required string value
}

/** 
 * This structure defines one key value set of report results
 */
struct ReportResultKeyValues {
	/**
	* the time range key
	*/
	1: required TimeRange range,
	
	/**
	* the metric values for this time range key
	*/
	2: required list<ReportMetricValue> values
}

/** 
 * This structure defines the result values (map of metric and values for each requested time ranges)
 */
struct ReportResultValues {
	/**
	* the type of report result value time ranges
	* For each report result groups, the system returns a map of ReportResultValues object (i.e.:a map of report metric (kpi) with their values) for each time range. 
	* These time ranges can be of different types (absolute defining exactly form a specific moment to another, or relative, starting at 0 for the first key, for cohort analysis).
	*/
	1: required ReportResultTimeRangeType type,
	
	/**
	* a map with a key for each time range (each day, each week, each month, ... depending on its meaning provided by the ReportResultTimeRangeType type) providing for each case a map of metric values
	*/
	2: required list<ReportResultKeyValues> values
}

/** 
 * This structure defines an optimization report returned
 * This object is specific to ChoiceReportRequest but is similar to all other type of report responses, as the only difference usually is the key object of the result variable (in this case: ChoiceReportResult)
*/
struct ChoiceReport {
	/**
	* the map of reporting results (one result per ChoiceReportResult: indicating choice variant, dimension value, etc.)
	*/
	1: required list<ChoiceReportResult> results,
	/**
	* the sum result
	*/
	2: required ReportResultValues sumResult
}

/**
 * This structure defines a transaction report request
 */
struct TransactionReportRequest {
	/**
	 * the metrics to evaluate report (e.g.: kpis to return)
	 */
	1: required list<ReportMetric> metrics,
	/**
	 * an optional list of dimensions for the report (for segmentation), while groups are different for each type of reporting, the dimension are normally standard (visitor country, device, ...)
	 */
	2: optional list<ReportDimension> dimensions,
	/**
	 * the report filter to use
	 */
	3: optional ReportFilter filter,
	/**
	 * optional: ONLY FOR COHORT ANALYSIS, the cohort customer id field (will consider all transactions of customers having this property indicating the customer id to belong to the same cohort)
	 * E.G.: for re-order rate, indicating the customer id field as the cohort customer id field will work, because each time the same customer re-order, then it is the same cohort re-ordering)
	 * E.G.: for viral-rate, indicating the customer field which contains the id of the customer who originated the suggestion to buy should be used a cohort customer id field
	 * N.B: Please consider that cohort analysis are basing the cohort time grouping on the precision TimeRangePrecision variable of the TransactionReportRequest)
	 */
	4: optional Field cohortIdField,
	/**
	 * the metrics to use for sorting the results
	 */
	5: optional list<ReportMetric> sortBys,
	/**
	 * a required date range for the reporting response (precision is only managed per day)
	 */
	6: required TimeRange range,
	/**
	 * a required date range precision if the results should be aggregated per week or month, overall or return for each day
	 */
	7: required TimeRangePrecision precision,
	/**
	 * an optional starting index (e.g.: if the maximum number of results was exceeded and a second page needs to be displayed). First index is 0.
	 */
	8: optional i16 startIndex,
	/**
	 * an required number of maximum number of results (one result is one source of date rage data in of values for all kpis)
	 */
	9: required i16 maxResults
}

/** 
 * This structure defines a map key (signature) of a transaction report result (indication about what this result is about)
 * The TransactionReport object contains a map with the results. For each key (i.e.: result group) the system returns a list of report metrics (kpis) and value for each date range requested.
 * These keys are, in the case of a TransactionReport defined by a map of dimension values for each requested Dimension
 */
struct TransactionReportResult {
	/**
	 * an required map of dimension values
	 */
	1: required list<ReportDimensionValue> dimensionValues,	
	/**
	* the report result values
	*/
	2: required ReportResultValues values
}

/** 
 * This structure defines a transaction report returned
 * This object is specific to TransactionReportRequest but is similar to all other type of report responses, as the only difference usually is the key object of the result variable (in this case: TransactionReportResult)
*/
struct TransactionReport {
	/**
	* the map of reporting results (one result per TransactionReportResult: indicating dimension values)
	*/
	1: required list<TransactionReportResult> results,
	/**
	* the sum result
	*/
	2: required ReportResultValues sumResult
}

/**
 * This structure defines a behavior report request
 */
struct BehaviorReportRequest {
	/**
	 * the metrics to evaluate report (e.g.: kpis to return)
	 */
	1: required list<ReportMetric> metrics,
	/**
	 * an optional list of dimensions for the report (for segmentation), while groups are different for each type of reporting, the dimension are normally standard (visitor country, device, ...)
	 */
	2: optional list<ReportDimension> dimensions,
	/**
	 * the report filter to use
	 */
	3: optional ReportFilter filter,
	/**
	 * the metrics to use for sorting the results
	 */
	4: optional list<ReportMetric> sortBys,
	/**
	 * a required date range for the reporting response (precision is only managed per day)
	 */
	5: required TimeRange range,
	/**
	 * a required date range precision if the results should be aggregated per week or month, overall or return for each day
	 */
	6: required TimeRangePrecision precision,
	/**
	 * an optional starting index (e.g.: if the maximum number of results was exceeded and a second page needs to be displayed). First index is 0.
	 */
	7: optional i16 startIndex,
	/**
	 * an required number of maximum number of results (one result is one source of date rage data in of values for all kpis)
	 */
	8: required i16 maxResults
}

/** 
 * This structure defines a map key (signature) of a behavior report result (indication about what this result is about)
 * The BehaviorReport object contains a map with the results. For each key (i.e.: result group) the system returns a list of report metrics (kpis) and value for each date range requested.
 * These keys are, in the case of a BehaviorReport defined by a map of dimension values for each requested Dimension
 */
struct BehaviorReportResult {
	/**
	 * an required map of dimension values
	 */
	1: required list<ReportDimensionValue> dimensionValues,	
	/**
	* the report result values
	*/
	2: required ReportResultValues values
}

/** 
 * This structure defines a behavior report returned
 * This object is specific to BehaviorReportRequest but is similar to all other type of report responses, as the only difference usually is the key object of the result variable (in this case: BehaviorReportResult)
*/
struct BehaviorReport {
	/**
	* the map of reporting results (one result per BehaviorReportResult: indicating dimension values)
	*/
	1: required list<BehaviorReportResult> results,
	/**
	* the sum result
	*/
	2: required ReportResultValues sumResult
}

service BoxalinoDataIntelligence {
/**
 * this service function returns a new authentication token
 *
 * <dl>
 * <dt>@param authentication</dt>
 * <dd>a fully complete AuthenticationRequest with the content of your credentials</dd>
 * <dt>@return</dt>
 * <dd>an Authentication object with your new authentication token (valid for 1 hour)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_CREDENTIALS:if the provided account / username / password information don't match the records of Boxalino system.</dd>
 * <dd>BLOCKED_USER:if the provided user has been blocked.</dd>
 * <dd>BLOCKED_ACCOUNT:if the provided account has been blocked.</dd>
 * </dl>
 */
	Authentication GetAuthentication(1: AuthenticationRequest authentication) throws (1: DataIntelligenceServiceException e),
	
	
/**
 * this service function changes the current password
 *
 * <dl>
 * <dt>@param authentication</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param newPassword</dt>
 * <dd>the new password to replace the existing one (careful, no forgot the new password, if you lose your password, contact <ahref="mailto:support@boxalino.com">support@boxalino.com</a></dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_NEW_PASSWORD:if the provided new password is not properly formatted (should be at least 8 characters long and not contain any punctuation).</dd>
 * </dl>
 */
	void UpdatePassword(1:	Authentication authentication, 2: string newPassword) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function returns the configuration version object matching the provided versionType. In general, you should always ask for the CURRENT_DEVELOPMENT_VERSION, unless you want to access directly (at your own risks) the production configuration.
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN: if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dt>@returns ConfigurationVersion</dt>
 * <dd>The configuration object to use in your calls to other service functions which access your configuration parameters</dd>
 * </dl>
 */
	ConfigurationVersion GetConfigurationVersion(1: Authentication authentication, 2: ConfigurationVersionType versionType) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function udpates your data source configuration.
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param dataSourcesConfigurationXML</dt>
 * <dd>the data source XML must follow the strict XML format and content as defined in the Boxalino documentation. This XML defines the way the system must extract data from the various files (typically a list of CSV files compressed in a zip file) to synchronize your product, customers and transactions data (tracker data are direclty provided to Boxalino Javascript tracker and are there not part of the data to be synchronized here. Please make sure that the product id is defined in a coherent way between he product files, the transaction files and the tracker (product View, add to basket and purchase event) (so the mapping can be done); same comment for the customer id: between the customer files, the transaction files and the tracker (set user event). If you don't have the full documentation of the data source XML, please contact <a href="mailto:support@boxalino.com">support@boxalino.com</a></dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>INVALID_DATASOURCE:if the provided new data source XML string doesn't match the required format (see documentation of the data source XML format)</dd>
 * <dt>@Nota Bene</dt>
 * <dd>If you remove fields definition from your data source, they will not be automatically deleted. You need to explicitely delte them through the delete component service function to remove them.</dd>
 * </dl>
 */
	void SetDataSourcesConfiguration(1: Authentication authentication, 2: ConfigurationVersion configurationVersion, 3: string dataSourcesConfigurationXML) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function returns the map of all the defined field (key = fieldId, value = Field object).
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dt>@returns map<string, Field></dt>
 * <dd>A map containing all the defined fields of your account in this configuration version, with the fieldId as key and the Field object as value (key is provided for accessibility only, as the field id is also present in the Field object</dd>
 * </dl>
 */
	map<string, Field> GetFields(1: Authentication authentication, 2: ConfigurationVersion configuration) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function creates a new field 
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param fieldId</dt>
 * <dd>the field id to be created (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>ALREADY_EXISTING_CONTENT_ID:if the provided field id already exists.</dd>
 * <dd>INVALID_CONTENT_ID:if the provided field id format is not valid.</dd>
 * </dl>
 */
	void CreateField(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string fieldId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function updates a field 
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param field</dt>
 * <dd>a Field object to be updated (the content of the object will be updated on the content id provided)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided field id doesn't already exists.</dd>
 * <dd>INVALID_CONTENT:if the provided field content is not valid.</dd>
 * <dd>The </dd>
 * </dl>
 */
	void UpdateField(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: Field field) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function deletes a field
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param fieldId</dt>
 * <dd>the field id to be deleted</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided field id doesn't already exists.</dd>
 * </dl>
 */
	void DeleteField(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string fieldId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function returns the map of all the defined process tasks (key = processTaskId, value = ProcessTask object).
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dt>@returns map<string, ProcessTask></dt>
 * <dd>A map containing all the defined process tasks of your account in this configuration version, with the processTaskId as key and the ProcessTask object as value (key is provided for accessibility only, as the processTaskId is also present in the ProcessTask object</dd>
 * </dl>
 */
	map<string, ProcessTask> GetProcessTasks(1: Authentication authentication, 2: ConfigurationVersion configuration) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function creates a new process task 
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param processTaskId</dt>
 * <dd>the process task id to be created (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>ALREADY_EXISTING_CONTENT_ID:if the provided process task id already exists.</dd>
 * <dd>INVALID_CONTENT_ID:if the provided process task id format is not valid.</dd>
 * </dl>
 */
	void CreateProcessTask(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string processTaskId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function updates a process task 
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param processTask</dt>
 * <dd>a ProcessTask object to be updated (the content of the object will be updated on the content id provided)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided process task id doesn't already exists.</dd>
 * <dd>INVALID_CONTENT:if the provided process task content is not valid.</dd>
 * <dd>The </dd>
 * </dl>
 */
	void UpdateProcessTask(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: ProcessTask processTask) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function deletes a process task
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param processTaskId</dt>
 * <dd>the process task id to be deleted</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided process task id doesn't already exists.</dd>
 * </dl>
 */
	void DeleteProcessTask(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string processTaskId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function executes a process task
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param processTaskId</dt>
 * <dd>the process task id to be executed</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided process task id doesn't already exists.</dd>
 * <dt>@return process id</dt>
 * <dd>the processs task execution id of this process task execution (to be used to get an updated status through GetProcessStatus)</dd>
 * </dl>
 */
	string RunProcessTask(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: ProcessTaskExecutionParameters parameters) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function returns the map of all the defined email campaigns (key = emailCampaignId, value = EmailCampaign object).
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dt>@returns map<string, EmailCampaign></dt>
 * <dd>A map containing all the defined email campaigns of your account in this configuration version, with the emailCampaignId as key and the EmailCampaign object as value (key is provided for accessibility only, as the emailCampaignId is also present in the EmailCampaign object</dd>
 * </dl>
 */
	map<string, EmailCampaign> GetEmailCampaigns(1: Authentication authentication, 2: ConfigurationVersion configuration) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function creates a new email campaign. a campaign is something permanent , so you shouldn't create one for each sending of a newsletter (but instead update the cmpid parameter of a permanent campaign e.g.: 'newsletter')
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param emailCampaignId</dt>
 * <dd>the email campaign id to be created (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>ALREADY_EXISTING_CONTENT_ID:if the provided email campaign id already exists.</dd>
 * <dd>INVALID_CONTENT_ID:if the provided email campaign id format is not valid.</dd>
 * </dl>
 */
	void CreateEmailCampaign(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string emailCampaignId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function updates a email campaign 
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param emailCampaign</dt>
 * <dd>a EmailCampaign object to be updated (the content of the object will be updated on the content id provided)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided email campaign id doesn't already exists.</dd>
 * <dd>INVALID_CONTENT:if the provided email campaign content is not valid.</dd>
 * <dd>The </dd>
 * </dl>
 */
	void UpdateEmailCampaign(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: EmailCampaign emailCampaign) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function deletes a email campaign
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param emailCampaignId</dt>
 * <dd>the email campaign id to be deleted</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided email campaign id doesn't already exists.</dd>
 * </dl>
 */
	void DeleteEmailCampaign(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string emailCampaignId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function returns the map of all the defined choices (key = choiceId, value = Choice object).
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param choiceSourceId</dt>
 * <dd>the choice source id (identifying the system being the source of the choices, if you don't have a choice source id already, please contact support@boxalino.com) (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dt>@returns map<string, Choice></dt>
 * <dd>A map containing all the defined choices of your account in this configuration version, with the choiceId as key and the Choice object as value (key is provided for accessibility only, as the choiceId is also present in the Choice object</dd>
 * </dl>
 */
	map<string, Choice> GetChoices(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string choiceSourceId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function creates a new choice
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dd>the choice source id (identifying the system being the source of the choices, if you don't have a choice source id already, please contact support@boxalino.com) (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@param choiceId</dt>
 * <dd>the choice id to be created (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>ALREADY_EXISTING_CONTENT_ID:if the provided choice id already exists.</dd>
 * <dd>INVALID_CONTENT_ID:if the provided choice id format is not valid.</dd>
 * </dl>
 */
	void CreateChoice(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string choiceSourceId, 4: string choiceId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function updates a choice 
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dd>the choice source id (identifying the system being the source of the choices, if you don't have a choice source id already, please contact support@boxalino.com) (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@param choice</dt>
 * <dd>a Choice object to be updated (the content of the object will be updated on the content id provided)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided choice id doesn't already exists.</dd>
 * <dd>INVALID_CONTENT:if the provided choice content is not valid.</dd>
 * <dd>The </dd>
 * </dl>
 */
	void UpdateChoice(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string choiceSourceId, 4: Choice choice) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function deletes a choice
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dd>the choice source id (identifying the system being the source of the choices, if you don't have a choice source id already, please contact support@boxalino.com) (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@param choiceId</dt>
 * <dd>the choice id to be deleted</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided choice id doesn't already exists.</dd>
 * </dl>
 */
	void DeleteChoice(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string choiceSourceId, 4: string choiceId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function returns the map of all the defined choices (key = choiceId, value = Choice object).
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dd>the choice source id (identifying the system being the source of the choices, if you don't have a choice source id already, please contact support@boxalino.com) (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@param choiceId</dt>
 * <dd>the choice id on which to get the choice variants from</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided choice id doesn't already exists.</dd>
 * <dt>@returns map<string, Choice></dt>
 * <dd>A map containing all the defined choice variants of your account in this configuration version and for this specific choice, with the choiceVariantId as key and the ChoiceVariant object as value (key is provided for accessibility only, as the choiceVariantId is also present in the ChoiceVariant object</dd>
 * </dl>
 */
	map<string, ChoiceVariant> GetChoiceVariants(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string choiceSourceId, 4: string choiceId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function creates a new choice
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dd>the choice source id (identifying the system being the source of the choices, if you don't have a choice source id already, please contact support@boxalino.com) (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@param choiceId</dt>
 * <dd>the choice id on which to create a new choice variant (must exists)</dd>
 * <dt>@param choiceVariantId</dt>
 * <dd>the choice variant id to be created (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided choice id doesn't already exists.</dd>
 * <dd>ALREADY_EXISTING_CONTENT_ID:if the provided choice variant id already exists.</dd>
 * <dd>INVALID_CONTENT_ID:if the provided choice variant id format is not valid.</dd>
 * </dl>
 */
	void CreateChoiceVariant(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string choiceSourceId, 4: string choiceId, 5: string choiceVariantId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function updates a choice 
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dd>the choice source id (identifying the system being the source of the choices, if you don't have a choice source id already, please contact support@boxalino.com) (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@param choiceVariant</dt>
 * <dd>a ChoiceVariant object to be updated (the content of the object will be updated on the content id provided)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided choice variant id doesn't already exists.</dd>
 * <dd>INVALID_CONTENT:if the provided choice variant content is not valid.</dd>
 * <dd>The </dd>
 * </dl>
 */
	void UpdateChoiceVariant(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string choiceSourceId, 4: ChoiceVariant choiceVariant) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function deletes a choice
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dd>the choice source id (identifying the system being the source of the choices, if you don't have a choice source id already, please contact support@boxalino.com) (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@param choiceId</dt>
 * <dd>the choice id on which to delete the choice variant id</dd>
 * <dt>@param choiceId</dt>
 * <dd>the choice variant id to be deleted</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided choice or choice variant id doesn't already exists.</dd>
 * </dl>
 */
	void DeleteChoiceVariant(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string choiceSourceId, 4: string choiceId, 5: string choiceVariantId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function retrieves a process status
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param processTaskExecutionId</dt>
 * <dd>the process task execution status id to retrieve the status of</dd>
 * <dt>@return process task execution status</dt>
 * <dd>the current status of this process task execution id</dd>
 * </dl>
 */
	ProcessTaskExecutionStatus GetProcessStatus(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string processTaskExecutionId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service retrieves the list of configuration changes between two versions (typically between dev and prod versions)
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersionSource</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion) to be considered as the source (typically the version returned by GetConfigurationVersion with the ConfigurationVersionType CURRENT_DEVELOPMENT_VERSION)</dd>
 * <dt>@param configurationVersionDestination</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion) to be considered as the destination (typically the  version returned by GetConfigurationVersion with the ConfigurationVersionType CURRENT_PRODUCTION_VERSION)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if one of provided configuration versions is not valid.</dd>
 * </dl>
 */
	list<ConfigurationDifference> GetConfigurationDifferences(1: Authentication authentication, 2: ConfigurationVersion configurationVersionSource, 3: ConfigurationVersion configurationVersionDestination) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service retrieves publishes the provided configuration version. The result is that this configuration will become the CURRENT_PRODUCTION_VERSION version and will be used automatically by all running processes. Also, as a consequence, a copy of the provided configuration version will be done and will become the new CURRENT_DEVELOPMENT_VERSION.
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * </dl>
 */
	void PublishConfiguration(1: Authentication authentication, 2: ConfigurationVersion configuration) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service copies the provided configuration version. The result is that this new configuration will become the CURRENT_DEVELOPMENT_VERSION.
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * </dl>
 */
	void CloneConfiguration(1: Authentication authentication, 2: ConfigurationVersion configuration) throws (1: DataIntelligenceServiceException e),

/**
 * This service is responsible for reference csv file creation. It allows to configure csv schema which will be imported as fields in DI.
 * File should be uploaded as an attachement to the POST HTTP request sent to the following URL:
 *      http://di1.bx-cloud.com/frontend/dbmind/_/en/dbmind/api/reference/csv/file/upload?iframeAccount={account}&fileHash={ReferenceCSVFileDescriptor.fileHash}
 * File hash is set by the API internally and cannot be changed.
 *
 * <dl>
 * <dt>@param authentication</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configuration</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param fileDescriptor</dt>
 * <dd>a ReferenceCSVFileDescriptor object describing the file that we want to create</dd>
 * <dt>@return</dt>
 * <dd>updated copy of ReferenceCSVFileDescriptor object describing the created file, with the file hash set</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>DUPLICATED_FILE_ID: if the given file identifier already exists</dd>
 * <dd>EMPTY_COLUMNS_LIST: if the given columns list is empty</dd>
 * </dl>
 */
	ReferenceCSVFileDescriptor CreateReferenceCSVFile(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: ReferenceCSVFileDescriptor fileDescriptor) throws (1: DataIntelligenceServiceException e),

/**
 * This service is responsible for updating reference csv file.
 *
 * <dl>
 * <dt>@param authentication</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configuration</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param fileDescriptor</dt>
 * <dd>an updated ReferenceCSVFileDescriptor object</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN: if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>EMPTY_COLUMNS_LIST: if the given columns list is empty</dd>
 * <dd>NON_EXISTING_FILE: if the file does not exist</dd>
 * </dl>
 */
	void UpdateReferenceCSVFile(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: ReferenceCSVFileDescriptor fileDescriptor) throws (1: DataIntelligenceServiceException e),

/**
 * This service is responsible for reference csv file removal.
 *
 * <dl>
 * <dt>@param authentication</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configuration</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param fileDescriptor</dt>
 * <dd>the ReferenceCSVFileDescriptor object to be removed</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN: if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_FILE: if the file does not exist</dd>
 * </dl>
 */
	void DeleteReferenceCSVFile(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: ReferenceCSVFileDescriptor fileDescriptor) throws (1: DataIntelligenceServiceException e),


/**
 * This service is responsible for getting all registered csv files.
 *
 * <dl>
 * <dt>@param authentication</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configuration</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@return</dt>
 * <dd>list of all reference csv files assigned to the current account</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN: if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * </dl>
 */
	list<ReferenceCSVFileDescriptor> GetAllReferenceCSVFiles(1: Authentication authentication, 2: ConfigurationVersion configuration) throws (1: DataIntelligenceServiceException e),


/**
 * this service function creates additional fields
 *
 * <dl>
 * <dt>@param authentication</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configuration</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param fieldsConfigurationXML</dt>
 * <dd>the fields configuration XML must follow the strict XML format and content as defined in the Boxalino documentation. This XML described fields which have to be created by parsing existing reference csv file.</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>INVALID_DATASOURCE_XML:if the provided new data source XML string doesn't match the required format (see documentation of the data source XML format)</dd>
 * </dl>
 */
	void CreateFieldsFromReferenceCSVFile(1: Authentication authentication, 2: ConfigurationVersion configurationVersion, 3: string fieldsConfigurationXML) throws (1: DataIntelligenceServiceException e),

/**
 * this service function returns the map of all the defined schedulings (key = schedulingId, value = Scheduling object).
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dt>@returns map<string, Scheduling></dt>
 * <dd>A map containing all the defined schedulings of your account in this configuration version, with the schedulingId as key and the Scheduling object as value (key is provided for accessibility only, as the schedulingId is also present in the Scheduling object</dd>
 * </dl>
 */
	map<string, Scheduling> GetSchedulings(1: Authentication authentication, 2: ConfigurationVersion configuration) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function creates a new scheduling. A scheduling is a collection of process tasks to be executed one after the other by the system.
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param schedulingId</dt>
 * <dd>the scheduling id to be created (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>ALREADY_EXISTING_CONTENT_ID:if the provided  scheduling id already exists.</dd>
 * <dd>INVALID_CONTENT_ID:if the provided scheduling id format is not valid.</dd>
 * </dl>
 */
	void CreateScheduling(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string schedulingId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function updates a scheduling. A scheduling is a collection of process tasks to be executed one after the other by the system.
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param scheduling</dt>
 * <dd>a Scheduling object to be updated (the content of the object will be updated on the content id provided)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided Scheduling id doesn't already exists.</dd>
 * <dd>INVALID_CONTENT:if the provided Scheduling content is not valid.</dd>
 * <dd>The </dd>
 * </dl>
 */
	void UpdateScheduling(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: Scheduling scheduling) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function deletes a scheduling. A scheduling is a collection of process tasks to be executed one after the other by the system.
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param schedulingId</dt>
 * <dd>the schedulingId to be deleted</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided schedulingId id doesn't already exists.</dd>
 * </dl>
 */
	void DeleteScheduling(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string schedulingId) throws (1: DataIntelligenceServiceException e),

/**
 * this service function executes a scheduling. A scheduling is a collection of process tasks to be executed one after the other by the system.
 *
 * <dl>
 * <dt>@param authentication</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configuration</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param parameters</dt>
 * <dd>parameters describing the scheduling which we want to execute</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided scheduling id doesn't already exists.</dd>
 * </dl>
 */
	void RunScheduling(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: SchedulingExecutionParameters parameters) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function returns the map of all the defined recommendation blocks (key = recommendationBlockId, value = RecommendationBlock object).
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dt>@returns map<string, RecommendationBlock></dt>
 * <dd>A map containing all the defined RecommendationBlocks of your account in this configuration version, with the RecommendationBlock id as key and the RecommendationBlock object as value (key is provided for accessibility only, as the RecommendationBlock id is also present in the RecommendationBlock object</dd>
 * </dl>
 */
	map<string, RecommendationBlock> GetRecommendationBlocks(1: Authentication authentication, 2: ConfigurationVersion configuration) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function creates a new RecommendationBlock. A RecommendationBlock is a visual block of recommendation for one page of your web-site (product detail page, basket page, etc.) you can have several recommendation blocks on the same page.
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param recommendationBlockId</dt>
 * <dd>the recommendation block id to be created (must follow the content id format: <= 50 alphanumeric characters without accent or punctuation)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>ALREADY_EXISTING_CONTENT_ID:if the provided  recommendationBlock id already exists.</dd>
 * <dd>INVALID_CONTENT_ID:if the provided recommendationBlock id format is not valid.</dd>
 * </dl>
 */
	void CreateRecommendationBlock(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string recommendationBlockId) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function updates a RecommendationBlock. A RecommendationBlock is a visual block of recommendation for one page of your web-site (product detail page, basket page, etc.) you can have several recommendation blocks on the same page.
 * 
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param recommendationBlock</dt>
 * <dd>a recommendationBlock object to be updated (the content of the object will be updated on the content id provided)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided RecommendationBlock id doesn't already exists.</dd>
 * <dd>INVALID_CONTENT:if the provided RecommendationBlock content is not valid.</dd>
 * <dd>The </dd>
 * </dl>
 */
	void UpdateRecommendationBlock(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: RecommendationBlock recommendationBlock) throws (1: DataIntelligenceServiceException e),
	
/**
 * this service function deletes a RecommendationBlock. A RecommendationBlock is a visual block of recommendation for one page of your web-site (product detail page, basket page, etc.) you can have several recommendation blocks on the same page.
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param recommendationBlockId</dt>
 * <dd>the recommendationBlockId to be deleted</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided recommendationBlockId id doesn't already exists.</dd>
 * </dl>
 */
	void DeleteRecommendationBlock(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string recommendationBlockId) throws (1: DataIntelligenceServiceException e),

/**
 * this service function gets all data sources defined for the account
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * </dl>
 */
	map<string, DataSource> GetDataSources(1: Authentication authentication, 2: ConfigurationVersion configuration) throws (1: DataIntelligenceServiceException e),

/**
 * this service function creates a new data source
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>ALREADY_EXISTING_CONTENT_ID: if the provided dataSourceId already exists.</dd>
 * </dl>
 */
	void CreateDataSource(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string dataSourceId) throws (1: DataIntelligenceServiceException e),

/**
 * this service function updates a DataSource
 * 
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param dataSource</dt>
 * <dd>a DataSource object to be updated (the content of the object will be updated on the content id provided)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided DataSource id doesn't already exists.</dd>
 * <dd>The </dd>
 * </dl>
 */
	void UpdateDataSource(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: DataSource dataSource) throws (1: DataIntelligenceServiceException e),

/**
 * this service function removes provided data source
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param dataSourceId</dt>
 * <dd>the identifier of the data source to be deleted</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided dataSourceId id doesn't already exists.</dd>
 * </dl>
 */
	void DeleteDataSource(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string dataSourceId) throws (1: DataIntelligenceServiceException e),

/**
 * this service function gets all data exports defined for the account
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * </dl>
 */
	map<string, DataExport> GetDataExports(1: Authentication authentication, 2: ConfigurationVersion configuration) throws (1: DataIntelligenceServiceException e),

/**
 * this service function creates new data export
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param dataExportId</dt>
 * <dd>the identifier of the data export to be deleted</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>ALREADY_EXISTING_CONTENT_ID: if the provided dataExportId already exists.</dd>
 * </dl>
 */
	void CreateDataExport(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string dataExportId) throws (1: DataIntelligenceServiceException e),

/**
 * this service function updates a DataExport
 * 
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param dataExport</dt>
 * <dd>a DataExport object to be updated (the content of the object will be updated on the content id provided)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided DataExport id doesn't already exists.</dd>
 * <dd>The </dd>
 * </dl>
 */
	void UpdateDataExport(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: DataExport dataExport) throws (1: DataIntelligenceServiceException e),

/**
 * this service function removes provided data export
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param dataExportId</dt>
 * <dd>the identifier of the data export to be deleted</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided dataSourceId id doesn't already exists.</dd>
 * </dl>
 */
	void DeleteDataExport(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string dataExportId) throws (1: DataIntelligenceServiceException e),

/**
 * this service function gets all data source defined for the account, but only these ones which use reference CSV files to retrieve the data
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * </dl>
 */
	map<string, ReferenceCSVDataSource> GetReferenceCSVFileDataSources(1: Authentication authentication, 2: ConfigurationVersion configuration) throws (1: DataIntelligenceServiceException e),

/**
 * this service function creates new reference csv data source
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param dataExportId</dt>
 * <dd>the identifier of the data export to be deleted</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>ALREADY_EXISTING_CONTENT_ID: if the provided dataSourceId already exists.</dd>
 * </dl>
 */
	void CreateReferenceCSVDataSource(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string dataSourceId) throws (1: DataIntelligenceServiceException e),

/**
 * this service function updates a reference CSV data source
 * 
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param dataSource</dt>
 * <dd>a ReferenceCSVDataSource object to be updated (the content of the object will be updated on the content id provided)</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided ReferenceCSVDataSource id doesn't already exists.</dd>
 * <dd>The </dd>
 * </dl>
 */
	void UpdateReferenceCSVDataSource(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: ReferenceCSVDataSource dataSource) throws (1: DataIntelligenceServiceException e),

/**
 * this service function removes provided reference CSV data source
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param dataSourceId</dt>
 * <dd>the identifier of the data source to be deleted</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>NON_EXISTING_CONTENT_ID:if the provided dataSourceId id doesn't already exists.</dd>
 * </dl>
 */
	void DeleteReferenceCSVDataSource(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: string dataSourceId) throws (1: DataIntelligenceServiceException e),
	
/**
 * This service function gets an identifier of last imported transaction. It can be useful for differential data synchronization.
 *
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@returns string</dt>
 * <dd>an identifier of the last transaction</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * </dl>
 */
        string GetLastTransactionID(1: Authentication authentication, 2: ConfigurationVersion configuration) throws (1: DataIntelligenceServiceException e),

/**
 * DEPRECITATED: USE GetChoiceReport service instead with ReportMetric: PAGE_VIEWS
 * This service function retrieves number of visits for each time range with selected precision.
 * 
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param range</dt>
 * <dd>a time range of generated reports</dd>
 * <dt>@param precision</dt>
 * <dd>a level of granularity</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>INVALID_RANGE: if the given time range is incorrect</dd>
 * </dl>
 */
	list<TimeRangeValue> GetPageViews(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: TimeRange range, 4: TimeRangePrecision precision) throws (1: DataIntelligenceServiceException e),
	
/**
 * This service function provides an choice statistical report. 
 * 
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param request</dt>
 * <dd>The statistical report request indicating the parameters of the requested report: dimension, metrics, etc.</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>INVALID_REPORT_REQUEST: if the provided report request is not valid.</dd>
 * </dl>
 */
	ChoiceReport GetChoiceReport(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: ChoiceReportRequest request) throws (1: DataIntelligenceServiceException e),
	
/**
 * This service function provides an transaction statistical report. 
 * 
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param request</dt>
 * <dd>The statistical report request indicating the parameters of the requested report: dimension, metrics, etc.</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>INVALID_REPORT_REQUEST: if the provided report request is not valid.</dd>
 * </dl>
 */
	TransactionReport GetTransactionReport(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: TransactionReportRequest request) throws (1: DataIntelligenceServiceException e),

/**
 * This service function provides an behavior statistical report. 
 * 
 * <dl>
 * <dt>@param authenticationToken</dt>
 * <dd>the authentication object as returned by the GetAuthentication service function in the AuthenticationResponse struct</dd>
 * <dt>@param configurationVersion</dt>
 * <dd>a ConfigurationVersion object indicating the configuration version number (as returned by function GetConfigurationVersion)</dd>
 * <dt>@param request</dt>
 * <dd>The statistical report request indicating the parameters of the requested report: dimension, metrics, etc.</dd>
 * <dt>@throws DataIntelligenceServiceException</dt>
 * <dd>INVALID_AUTHENTICATION_TOKEN:if the provided authentication token is not valid or has expired (1 hour validity).</dd>
 * <dd>INVALID_CONFIGURATION_VERSION: if the provided configuration version is not valid.</dd>
 * <dd>INVALID_REPORT_REQUEST: if the provided report request is not valid.</dd>
 * </dl>
 */
	BehaviorReport GetBehaviorReport(1: Authentication authentication, 2: ConfigurationVersion configuration, 3: BehaviorReportRequest request) throws (1: DataIntelligenceServiceException e),
	
}
