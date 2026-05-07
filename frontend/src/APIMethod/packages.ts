import { api } from "./client";

export interface Packages {
  id: number;
  name: string;
  hours: number;
  price: string;
  duration_days: number;
  type: string;
  price_per_hour: number;
}

export interface GetPackagesResponse {
  data: Packages;
  message: string;
}

export interface CreatePackageData {
  name: string;
  hours: number;
  duration_days: number;
  price: string;
}

export interface CreatePackageResponse {
  data: Packages;
  message: string;
}

export interface DeletePackageResponse {
  data: string;
  message: string;
}

export interface UpdatePackageData {
  name: string;
  hours: number;
  duration_days: number;
  price: string;
  is_active: string;
}

export interface UpdatePackageResponse {
  data: Packages;
}

export const packagesApi = {
  getPackage: async (): Promise<{ data: Packages[] }> => {
    return api.get<{ data: Packages[] }>("/packages");
  },

  addPackage: async (
    packageData: CreatePackageData,
  ): Promise<CreatePackageResponse> => {
    return api.post<CreatePackageResponse>("/packages", packageData);
  },

  deletePackage: async (id: number): Promise<DeletePackageResponse> => {
    return api.delete<DeletePackageResponse>(`/packages/${id}`);
  },

  updatePackage: async (
    id: number | string,
    packageData: UpdatePackageData,
  ): Promise<UpdatePackageResponse> => {
    return api.put<UpdatePackageResponse>(`/packages/${id}`, packageData);
  },
};
