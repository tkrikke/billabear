import axios from 'axios';

export function useApi(baseUrl) {
  const get = async (path) => (await axios.get(`${baseUrl}/${path}`)).data;
  const post = async (path, data) => (await axios.post(`${baseUrl}/${path}`, data)).data;
  return { get, post };
}
