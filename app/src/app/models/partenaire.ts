import { Model } from "./model";

export class Partenaire extends Model<Partenaire>{
    nom!: string;
    site_web!: string;
    logo_url!: string;
}