import Keycloak from 'keycloak-js';

const keycloakConfig = {
  url: process.env.REACT_APP_REAL_KEYCLOACK ? 'http://49.12.120.110:8081/auth' : 'http://localhost:8080/auth',
  realm: 'react-marathon',
  clientId: 'react-marathon-app',
};
const keycloak = new Keycloak(keycloakConfig);
export default keycloak;
