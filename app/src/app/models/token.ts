export interface Token {
    accessToken: string;
    token:       Extract;
}

export interface Extract{
    id:         string;
    user_id:    number;
    client_id:  number;
    name:       null;
    scopes:     any[];
    revoked:    boolean;
    created_at: Date;
    updated_at: Date;
    expires_at: Date;
}