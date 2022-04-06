export interface Admin {
  id: number;
  email: string;
  full_name: string;
  permissions: Permission[];
  tab_permission:string[];
}

export interface Permission {
  name: string;
  guard_name: string;
  id: number;
}
