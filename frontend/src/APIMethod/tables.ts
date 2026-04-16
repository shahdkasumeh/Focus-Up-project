// APIMethod/tables.ts
import { api } from "./client";

export interface Table {
  id: number;
  table_num: number;
  is_active: number;
  is_occupied: number;
  room_id: number;
}

export interface AddTableData {
  table_num: number;
  room_id: number;
}

export interface AddTableResponse {
  data: Table;
  message: string;
}

export interface DeleteTableResponse {
  data: string;
  message: string;
}

export interface UpdateTableData {
  id: number;
  table_num: number;
  room_id: number;
}

export interface UpdateTableResponse {
  data: Table;
}

export const tablesApi = {
  getAllTables: async (): Promise<{ data: Table[] }> => {
    return api.get<{ data: Table[] }>("/tables");
  },
  addTable: async (tableData: AddTableData): Promise<AddTableResponse> => {
    return api.post<AddTableResponse>("/tables", tableData);
  },
  deleteRoom: async (id: number): Promise<DeleteTableResponse> => {
    return api.delete<DeleteTableResponse>(`/rooms/${id}`);
  },

  updateTable: async (
    tableData: UpdateTableData,
  ): Promise<UpdateTableResponse> => {
    const { id, ...data } = tableData;

    return api.put<UpdateTableResponse>(`/tables/${id}`, data);
  },
};
