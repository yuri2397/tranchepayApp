export interface Admin {
  id: number;
  email: string;
  full_name: string;
  password: string;
  permissions: Permission[];
}

export interface Permission {
  name: string;
  guard_name: string;
  id: number;
}
