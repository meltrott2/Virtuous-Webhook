CREATE TABLE contacts (
  ContactID INT PRIMARY KEY NOT NULL,
  ContactName VARCHAR(255) NOT NULL,
  ContactType VARCHAR(25) NOT NULL,
  GiftAskAmount DECIMAL(10, 2) NOT NULL,
  LastGiftAmount DECIMAL(10, 2),
  LastGiftDate DATE
);

CREATE TABLE individuals (
  IndividualID INT PRIMARY KEY NOT NULL,
  ContactID INT NOT NULL,
  FirstName VARCHAR(25) NOT NULL,
  LastName VARCHAR(25) NOT NULL,
  PhoneNumber VARCHAR(20),
  Email VARCHAR(255),
  FOREIGN KEY (ContactID) REFERENCES contacts (ContactID) ON DELETE CASCADE
);

CREATE TABLE communications (
  CommunicationID INT PRIMARY KEY NOT NULL,
  CommunicationName VARCHAR(100) NOT NULL,
  ChannelType VARCHAR(100) NOT NULL
);

CREATE TABLE campaigns (
  CampaignID INT PRIMARY KEY NOT NULL,
  CampaignName VARCHAR(100) NOT NULL,
  CommunicationID INT NOT NULL,
  FOREIGN KEY (CommunicationID) REFERENCES communications (CommunicationID) ON DELETE CASCADE
);

CREATE TABLE segments (
  SegmentID INT PRIMARY KEY NOT NULL,
  SegmentCode VARCHAR(50) NOT NULL,
  SegmentName VARCHAR(100) NOT NULL,
  CampaignID INT NOT NULL,
  FOREIGN KEY (CampaignID) REFERENCES campaigns (CampaignID) ON DELETE CASCADE
);

CREATE TABLE gifts (
  GiftID INT PRIMARY KEY NOT NULL,
  Amount DECIMAL(10, 2) NOT NULL,
  GiftType VARCHAR(50) NOT NULL,
  GiftDate DATE NOT NULL,
  ContactID INT NOT NULL,
  IndividualID INT,
  SegmentCode INT NOT NULL,
  FOREIGN KEY (ContactID) REFERENCES contacts (ContactID) ON DELETE CASCADE,
  FOREIGN KEY (IndividualID) REFERENCES individuals (IndividualID) ON DELETE CASCADE,
  FOREIGN KEY (SegmentCode) REFERENCES segments (SegmentCode) ON DELETE CASCADE
);

CREATE TABLE tags (
  TagID INT PRIMARY KEY NOT NULL,
  TagName VARCHAR(50) NOT NULL
);

CREATE TABLE contact_tags (
  ContactID INT NOT NULL,
  TagID INT NOT NULL,
  PRIMARY KEY (ContactID, TagID),
  FOREIGN KEY (ContactID) REFERENCES contacts (ContactID) ON DELETE CASCADE,
  FOREIGN KEY (TagID) REFERENCES tags (TagID) ON DELETE CASCADE
);