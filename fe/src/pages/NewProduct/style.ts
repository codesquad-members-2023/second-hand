import styled from 'styled-components';

export const Layout = styled.div`
  width: 100vw;
  .empty {
    height: 10vh;
  }

  & hr {
    width: 95vw;
    background: ${({ theme }) => theme.color.palette.gray500};
    height: 1px;
    border: 0;
  }

  & input {
    width: 90vw;
    height: 3vh;
    border: none;
  }
`;
export const ContentBox = styled.div``;

export const SaveImgBox = styled.div`
  padding: 10px;
`;

export const TitleBox = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding-left: 10px;
`;

export const PriceBox = styled.div`
  display: flex;
  margin: 10px;
  align-items: center;
  & label {
    color: ${({ theme }) => theme.color.colors.neutralText};
  }
`;

export const DetailBox = styled.div`
  display: flex;
  margin: 10px;
  align-items: center;
  justify-content: center;

  & textarea {
    width: 90vw;
    height: 55vh;
    border: none;
  }
`;

export const CategoryBox = styled.div`
  width: 95vw;
  display: flex;
  align-items: center;
  justify-content: space-between;
`;

export const CategoryBtnBox = styled.div`
  display: flex;
  align-items: center;
  gap: 5px;
`;
