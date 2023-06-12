import styled from 'styled-components';

export interface IconStyleProps {
  size?: number;
  color?: string;
}

export const Icon = styled.div<IconStyleProps>`
  font-family: 'SF Pro', fallback, sans-serif;
  display: flex;
  align-items: center;
  justify-content: center;
  width: ${({ size }) => size}px;
  height: ${({ size }) => size}px;
  font-size: ${({ size }) => size}px;
  color: ${({ theme, color }) =>
    color ? theme.colors[color] : theme.colors.neutralText};
`;
