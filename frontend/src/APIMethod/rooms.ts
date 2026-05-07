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

export interface CreateRoomResponse {
  data: Room;
  message: string;
}

export interface UpdateRoomData {
  id: number;
  status: string;
}

export interface UpdateRoomResponse {
  data: Room;
}

export interface DeleteRoomResponse {
  data: string;
  message: string;
}

export const roomsApi = {
  addRoom: async (roomData: CreateRoomData): Promise<CreateRoomResponse> => {
    return api.post<CreateRoomResponse>("/rooms", roomData);
  },

  getRooms: async (): Promise<{ data: Room[] }> => {
    return api.get<{ data: Room[] }>("/rooms");
  },

  deleteRoom: async (id: number): Promise<DeleteRoomResponse> => {
    return api.delete<DeleteRoomResponse>(`/rooms/${id}`);
  },

  updateRooms: async (
    roomData: UpdateRoomData,
  ): Promise<UpdateRoomResponse> => {
    const { id, ...data } = roomData;

    return api.put<UpdateRoomResponse>(`/rooms/${id}`, data);
  },
};
