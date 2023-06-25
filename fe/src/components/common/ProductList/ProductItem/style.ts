import styled from 'styled-components';

import { fontType } from '@Styles/font';

export const Layout = styled.div`
  display: flex;
  gap: 10px;
  width: 100vw;
  justify-content: center;
  align-items: center;
  padding-top: 2vh;
`;
export const ImgBox = styled.div`
  width: 30vw;
  height: 12vh;
  > img {
    width: 100%;
    height: 100%;
    border-radius: 10px;
  }
`;
export const TitleBox = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 60vw;
  ${fontType.subHead}
`;
export const ContentBox = styled.div`
  display: flex;
  flex-direction: column;
  gap: 5px;
`;
export const LocationBox = styled.div`
  color: ${({ theme }) => theme.color.palette.gray800};
  ${({ theme }) => theme.font.fontType.footNote};
`;
export const PriceBox = styled.div`
  color: ${({ theme }) => theme.color.palette.black};
  ${({ theme }) => theme.font.fontType.headLine};
  display: flex;
  gap: 3px;
  align-items: center;
`;

export const IconBox = styled.div`
  ${({ theme }) => theme.font.fontType.footNote};
  color: ${({ theme }) => theme.color.palette.gray900};
  display: flex;
  justify-content: flex-end;
  align-items: center;
  gap: 3px;
`;
