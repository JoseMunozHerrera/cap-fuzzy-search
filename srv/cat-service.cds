using {
  central.common,
  sap.common.Countries as CountriesTbl
} from '../db/data-model';

service CatalogService {
  entity Countries @readonly as projection on CountriesTbl;
  entity Regions @readonly   as projection on common.Regions;
}