import React, { useState, useEffect } from 'react';

import { AUTH, KAKAO } from '@constants/API';

import kakaoFetch from 'src/apis/instances/kakaoFetch';
import useCurrentRegion from '@hooks/useCurrentRegion';

import LoginHeader from '@components/Login/LoginHeader';
import LoginMain from '@components/Login/LoginMain';

import { $Template } from '@styles/PageTemplate.style';
import { Outlet } from 'react-router-dom';

const Login = () => {
  const { region, error } = useCurrentRegion();

  const handleLoginBtnClick = () => {
    const scope = 'user';
    const clientId = process.env.REACT_APP_CLIENT_ID as string;

    window.location.href = AUTH.GITHUB_LOGIN_URL(clientId, scope);
  };

  return (
    <$Template>
      <LoginHeader />
      <LoginMain onClick={handleLoginBtnClick} region={region} />
      <Outlet />
    </$Template>
  );
};

export default Login;
