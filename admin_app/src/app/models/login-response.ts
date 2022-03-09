import { Admin } from './admin';
import { Token } from './token';
export interface LoginResponse {
  token:      Token;
  user:       Admin;
  model_type: string;
}
