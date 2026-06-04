import { api } from "./client";

export interface Prizes {
  id: number;
  name: string;
  value: string;
  probability: number;
}

export interface CreatePrizeData {
  name: string;
  value: string;
  probability: number;
}

export interface CreatePrizeResponse {
  data: Prizes;
  message: string;
}

export interface UpdatePrizeData {
  name: string;
  value: string;
  probability: number;
}

export interface UpdatePrizeResponse {
  data: Prizes;
  message: string;
}

export interface DeletePrizeResponse {
  data: string;
  message: string;
}
export interface GetPrizesResponse {
  data: Prizes[];
  message: string;
}

export const prizesApi = {
  getPrizes: async (): Promise<Prizes[]> => {
    const response = await api.get<GetPrizesResponse>("/getAllPrize");
    const prizes = response.data || [];
    return prizes.map((prize) => ({
      ...prize,
      probability: prize.probability ?? 0,
    }));
  },

  addPrizes: async (
    prizesData: CreatePrizeData,
  ): Promise<CreatePrizeResponse> => {
    return api.post<CreatePrizeResponse>("/createLuckyWheel", prizesData);
  },
  updatePrizes: async (
    id: number | string,
    prizesData: UpdatePrizeData,
  ): Promise<UpdatePrizeResponse> => {
    return api.put<UpdatePrizeResponse>(`/updatePrize/${id}`, prizesData);
  },

  deletePrizes: async (id: number): Promise<DeletePrizeResponse> => {
    return api.delete<DeletePrizeResponse>(`/deletePrize/${id}`);
  },
};
