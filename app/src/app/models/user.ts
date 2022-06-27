import { Permission } from './role';
import { Commande } from './commande';

export interface User {
  id: number;
  username: string;
  email: string;
  email_verify_at: null;
  etat: number;
  model: number;
  model_type: string;
  permissions: Permission[];
  created_at: Date;
  updated_at: Date;
}
