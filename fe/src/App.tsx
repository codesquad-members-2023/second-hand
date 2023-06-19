import React from 'react';
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';

import { ThemeProvider } from 'styled-components';
import GlobalStyles from '@styles/GlobalStyles.style';
import { theme } from '@styles/theme';

import PATH from '@constants/routerPath';

import Login from '@pages/Login';
import Auth from '@pages/Auth';
import HomeMain from '@pages/Home/HomeMain';

const App = () => {
  return (
    <ThemeProvider theme={theme}>
      <GlobalStyles />
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<Navigate to={PATH.HOME.DEFAULT} />} />
          <Route path={PATH.HOME.DEFAULT} element={<HomeMain />} />
          <Route path={PATH.HOME.TOWN_SETTING} />
          <Route path={PATH.HOME.TOWN_SEARCH} />
          <Route path={PATH.HOME.CATEGORY} />

          <Route path={PATH.SALE.DEFAULT} />
          <Route path={PATH.SALE.CATEGORY} />

          <Route path={PATH.PRODUCT.DEFAULT} />
          <Route path={PATH.PRODUCT.CHAT} />
          <Route path={PATH.PRODUCT.SALES} />
          <Route path={PATH.PRODUCT.LIKE} />

          <Route path={PATH.AUTH.DEFAULT} element={<Auth />} />
          <Route path={PATH.AUTH.LOGIN} element={<Login />} />
          <Route path={PATH.AUTH.SETTING} />
        </Routes>
      </BrowserRouter>
    </ThemeProvider>
  );
};

export default App;
