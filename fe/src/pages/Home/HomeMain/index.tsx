import React, { useEffect, useState } from 'react';

import useIntersectionObserver from '@hooks/useIntersectionObserver';
import MainTabBar from '@molecules/TabBars/MainTabBar';
import { $Template } from '@styles/PageTemplate.style';
import mockAxiosFetch from '@apis/instances/mockAxiosFetch';

import HomeMainHeader from '@components/Home/HomeMain/HomeMainHeader';
import HomeMainMain from '@components/Home/HomeMain/HomeMainMain';

interface Product {
  productId: number;
  title: string;
  town: { townId: number; name: string };
  createdAt: string;
  status: string;
  price: number;
  countInfo: { chatCount: number; likeCount: number };
  imgUrl: string;
}

interface Town {
  townId: number;
  name: string;
}

const HomeMain = () => {
  const [products, setProducts] = useState<Product[]>([]);
  const [towns, setTowns] = useState<Town[]>([]);
  const [pageNum, setPageNum] = useState(1);
  const [isPageUpdated, setIsPageUpdated] = useState(false);

  const intersectionObserverCallback = (entries: IntersectionObserverEntry[]) => {
    const entry = entries[0];

    if (!entry.isIntersecting || isPageUpdated) return;
    if (entry.isIntersecting) setPageNum(prevPageNum => prevPageNum + 1);
    setIsPageUpdated(true);
  };

  const observerTarget = useIntersectionObserver(intersectionObserverCallback);

  useEffect(() => {
    const getProducts = async () => {
      const response = await mockAxiosFetch('/products', {
        method: 'GET',
        params: {
          pageNum, // 현재 페이지를 API로 전달
        },
      });
      const data = await response.data;
      const isSuccess = data.success;
      const newProducts = data.data.products;

      // FIXME(jayden): error handling 수정하기
      if (!isSuccess) throw new Error('Failed to fetch products');
      setProducts(prevProducts => [...prevProducts, ...newProducts]);
    };

    // NOTE(jayden): strict mode로 인해 두번씩 호출됨
    getProducts();
  }, [pageNum]);

  useEffect(() => {
    const getTowns = async () => {
      const response = await mockAxiosFetch('/towns/member', {
        method: 'GET',
      });
      const data = await response.data;
      const isSuccess = data.success;
      const towns = data.data.town;

      if (!isSuccess) throw new Error('Failed to fetch towns');
      setTowns(towns);
    };

    getTowns();
  }, []);

  return (
    <>
      {!!products.length && !!towns.length && (
        <$Template>
          <HomeMainHeader towns={towns} />
          <HomeMainMain products={products} observerTarget={observerTarget} />
          <MainTabBar />
        </$Template>
      )}
    </>
  );
};

export default HomeMain;
