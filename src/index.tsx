import 'react-app-polyfill/stable';
import React, { Suspense } from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter } from 'react-router-dom';
import { ReactKeycloakProvider } from '@react-keycloak/web';

import App from './components/App';
import keycloak from './keycloak';

const tokenUpdater = (tokens: { [key: string]: string }) => {
  localStorage.setItem('token', tokens.token);
};

ReactDOM.render(
  <React.StrictMode>
    <ReactKeycloakProvider authClient={keycloak} initOptions={{ onLoad: 'login-required' }} onTokens={tokenUpdater}>
      <BrowserRouter>
        <Suspense fallback={<div>Loading...</div>}>
          <App />
        </Suspense>
      </BrowserRouter>
    </ReactKeycloakProvider>
  </React.StrictMode>,
  document.getElementById('root'),
);
