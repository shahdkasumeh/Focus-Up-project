import { api } from "./client";

export interface Room {
  id: number;
  name: string;
  type: string;
  capacity: number;
  is_active: number;
  is_occupied: number;
  status: string;
}

export interface CreateRoomData {
  name: string;
  type: string;
  capacity: number;
}

export interface AddRoomResponse {
  data: Room;
  message: string;
}

export const roomsApi = {
  addRoom: async (roomData: CreateRoomData): Promise<AddRoomResponse> => {
    return api.post<AddRoomResponse>("/rooms", roomData);
  },

  getRooms: async (): Promise<{ data: Room[] }> => {
    return api.get<{ data: Room[] }>("/rooms");
  },
};
