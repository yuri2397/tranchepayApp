export class Role {
    name!: string;
}


export interface Permission {
    id:         number;
    name:       string;
    guard_name: string;
    created_at: Date;
    updated_at: Date;
    pivot:      Pivot;
}

export interface Pivot {
    model_id:      string;
    permission_id: number;
    model_type:    string;
}