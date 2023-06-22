import { useState, useMemo } from 'react';
import { Link } from 'react-router-dom';

import { ICON_NAME, REQUEST_METHOD } from '@constants/index';
import { getRegion } from '@utils/index';

import useFetch from '@hooks/useFetch';

import Icon from '@components/common/Icon';
import * as S from './style';

interface Region {
  id: number;
  name: string;
}

interface RegionsData {
  regions: Region[];
}

const HomeHeader = () => {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const { data } = useFetch<RegionsData>({
    url: 'http://13.124.150.120:8080/users/regions',
    method: REQUEST_METHOD.GET,
  });
  const isLoggedIn = localStorage.getItem('Token');

  const defaultRegion = useMemo(() => {
    if (!isLoggedIn) return '역삼 1동';
    if (!data) return;

    const address = data.regions[0].name;
    const region = getRegion(address);

    return region;
  }, [data]);

  const getDropDownMenuTemplate = () => {
    if (!isLoggedIn) {
      return (
        <S.Menu defaultregion={defaultRegion} region={defaultRegion}>
          {defaultRegion}
        </S.Menu>
      );
    }

    return (
      <>
        {data?.regions.map(({ id, name }) => (
          <S.Menu key={id} defaultregion={defaultRegion} region={getRegion(name)}>
            {getRegion(name)}
          </S.Menu>
        ))}
        <Link to="/region-setting">
          <S.Menu>내 동네 설정하기</S.Menu>
        </Link>
      </>
    );
  };

  return (
    <S.HomeHeader>
      <S.NeighborhoodDropdown onClick={() => setIsModalOpen(!isModalOpen)}>
        <span>{defaultRegion}</span>
        <Icon name={ICON_NAME.CHEVRON_DOWN} />
        {isModalOpen && <S.Modal>{getDropDownMenuTemplate()}</S.Modal>}
      </S.NeighborhoodDropdown>
      <Link to="/categories">
        <Icon name={ICON_NAME.HAMBURGER} />
      </Link>
    </S.HomeHeader>
  );
};

export default HomeHeader;
