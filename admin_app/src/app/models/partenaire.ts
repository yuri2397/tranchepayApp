export class Partenaire{
    readonly id!: string;
    nom!: string;
    logo_url!: string;
    site_web!: string;
    search!: boolean;
    load: boolean;
    edited: boolean;

    constructor(){
        this.search = false;
        this.load = false;
        this.edited = false
    }
}