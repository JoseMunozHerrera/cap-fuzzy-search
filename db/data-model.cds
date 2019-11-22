namespace central.common;

using {
  User,
  sap.common.Countries as CountriesType,
  Language,
  managed
} from '@sap/cds/common';
using sap from '@sap/cds/common';

extend CountriesType {
  code1           : Integer @(
    title        : '{i18n>code1}',
    Common.Label : '{i18n>code1}'
  );
  alpha3          : String(3) @(
    title        : '{i18n>alpha3}',
    Common.Label : '{i18n>alpha3}'
  );
  iso             : String(16) @(
    title        : '{i18n>iso}',
    Common.Label : '{i18n>iso}'
  );
  region          : String(20) @(
    title        : '{i18n>region}',
    Common.Label : '{i18n>region}'
  );
  sub_region      : String(40) @(
    title        : '{i18n>sub_region}',
    Common.Label : '{i18n>sub_region}'
  );
  region_code     : String(3) @(
    title        : '{i18n>region_code}',
    Common.Label : '{i18n>region_code}'
  );
  sub_region_code : String(3) @(
    title        : '{i18n>sub_region_code}',
    Common.Label : '{i18n>sub_region_code}'
  );
  regions         : Composition of many Regions
                      on regions.country = $self.code;
}

entity Regions {
  key country                    : String(3)      @(
        title        :        '{i18n>country}',
        Common.Label :        '{i18n>country}'
      );
  key sub_code                   : String(5)      @(
        title        :        '{i18n>sub_code}',
        Common.Label :        '{i18n>sub_code}'
      );
      toCountries                : Association to one CountriesType
                                     on toCountries.code = $self.country;
      name                       : String(80)     @(
        title               : '{i18n>name}',
        Common.FieldControl : #Mandatory,
        Search.defaultSearchElement,
        Common.Label        : '{i18n>name}'
      );
      type                       : String(80)     @(
        title        :        '{i18n>type}',
        Common.Label :        '{i18n>type}'
      );
      virtual score              : Decimal(10, 3) @(
        title        :        '{i18n>score}',
        Common.Label :        '{i18n>score}'
      );
      virtual descriptionSnippet : String         @(
        title        :        '{i18n>name}',
        UI.HiddenFilter,
        Common.Label :        '{i18n>name}'
      );
}

define view iso_countries_regions as
  select from Regions {
    country          as COUNTRY_CODE,
    toCountries.name as COUNTRY_NAME,
    sub_code,
    name,
    type
  };

define view iso_us_states as
  select from Regions {
    sub_code,
    name
  }
  where
        country = 'US'
    and type    = 'State';

define view iso_us_states_and_territories as
  select from Regions {
    sub_code,
    name
  }
  where
    country = 'US';