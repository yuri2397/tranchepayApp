import { Client } from './client';
import { Commercant } from './commercant';
import { Token } from './token';
import { User } from './user';

export interface LoginResponse {
    token:      Token;
    user:       User;
    data:       Client|Commercant;
    model_type: string;
}