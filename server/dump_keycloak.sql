--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;


--
-- Databases
--

--
-- Database "template1" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0 (Debian 14.0-1.pgdg110+1)
-- Dumped by pg_dump version 14.0 (Debian 14.0-1.pgdg110+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: dnedtjrx
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO dnedtjrx;

\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: dnedtjrx
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: dnedtjrx
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: dnedtjrx
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- Database "dnedtjrx" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0 (Debian 14.0-1.pgdg110+1)
-- Dumped by pg_dump version 14.0 (Debian 14.0-1.pgdg110+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: dnedtjrx; Type: DATABASE; Schema: -; Owner: dnedtjrx
--

\connect dnedtjrx

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO dnedtjrx;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO dnedtjrx;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO dnedtjrx;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO dnedtjrx;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO dnedtjrx;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO dnedtjrx;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO dnedtjrx;

--
-- Name: client; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO dnedtjrx;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO dnedtjrx;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO dnedtjrx;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO dnedtjrx;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO dnedtjrx;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO dnedtjrx;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO dnedtjrx;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO dnedtjrx;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO dnedtjrx;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO dnedtjrx;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO dnedtjrx;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO dnedtjrx;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO dnedtjrx;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO dnedtjrx;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO dnedtjrx;

--
-- Name: component; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO dnedtjrx;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO dnedtjrx;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO dnedtjrx;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO dnedtjrx;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO dnedtjrx;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO dnedtjrx;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO dnedtjrx;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO dnedtjrx;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO dnedtjrx;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO dnedtjrx;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO dnedtjrx;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO dnedtjrx;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO dnedtjrx;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO dnedtjrx;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO dnedtjrx;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO dnedtjrx;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO dnedtjrx;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO dnedtjrx;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO dnedtjrx;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO dnedtjrx;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO dnedtjrx;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO dnedtjrx;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO dnedtjrx;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO dnedtjrx;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO dnedtjrx;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO dnedtjrx;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO dnedtjrx;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO dnedtjrx;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO dnedtjrx;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO dnedtjrx;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO dnedtjrx;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO dnedtjrx;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO dnedtjrx;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO dnedtjrx;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO dnedtjrx;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO dnedtjrx;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO dnedtjrx;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO dnedtjrx;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO dnedtjrx;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO dnedtjrx;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO dnedtjrx;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO dnedtjrx;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO dnedtjrx;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO dnedtjrx;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO dnedtjrx;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO dnedtjrx;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO dnedtjrx;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO dnedtjrx;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO dnedtjrx;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO dnedtjrx;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO dnedtjrx;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO dnedtjrx;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO dnedtjrx;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO dnedtjrx;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO dnedtjrx;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO dnedtjrx;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO dnedtjrx;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO dnedtjrx;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO dnedtjrx;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO dnedtjrx;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO dnedtjrx;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO dnedtjrx;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO dnedtjrx;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO dnedtjrx;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO dnedtjrx;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO dnedtjrx;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO dnedtjrx;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO dnedtjrx;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO dnedtjrx;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: dnedtjrx
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO dnedtjrx;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
e1af907e-47e5-436d-97de-9fa89e282caa	\N	auth-cookie	master	19ecbefd-67ac-4f96-bf4e-1d443ac35b0a	2	10	f	\N	\N
799940e9-351a-46bc-8829-88777ed01e1f	\N	auth-spnego	master	19ecbefd-67ac-4f96-bf4e-1d443ac35b0a	3	20	f	\N	\N
4ae0359c-959b-4594-aed2-222ae25e25f3	\N	identity-provider-redirector	master	19ecbefd-67ac-4f96-bf4e-1d443ac35b0a	2	25	f	\N	\N
bf43c0f2-ca4e-45b1-9555-58d4932b94dc	\N	\N	master	19ecbefd-67ac-4f96-bf4e-1d443ac35b0a	2	30	t	0c77c455-1444-4c9e-a7bf-461754440723	\N
abed43a3-765d-461f-92f3-43ef6b69b32e	\N	auth-username-password-form	master	0c77c455-1444-4c9e-a7bf-461754440723	0	10	f	\N	\N
2677bc3d-fc35-4d6d-aacc-7675540de22d	\N	\N	master	0c77c455-1444-4c9e-a7bf-461754440723	1	20	t	c3d8445a-a486-4e2c-ac04-3406dbe4e10d	\N
28694031-f36f-4848-8002-4a9b977b4077	\N	conditional-user-configured	master	c3d8445a-a486-4e2c-ac04-3406dbe4e10d	0	10	f	\N	\N
5152319a-aa7d-420d-8e80-52a119f0521b	\N	auth-otp-form	master	c3d8445a-a486-4e2c-ac04-3406dbe4e10d	0	20	f	\N	\N
f1051f7c-da30-4313-a408-e5fbe58b817b	\N	direct-grant-validate-username	master	be4ed342-4806-499d-a3ca-c0e919e13ec1	0	10	f	\N	\N
2bba8012-50fb-47de-a16d-cf31cc05c13e	\N	direct-grant-validate-password	master	be4ed342-4806-499d-a3ca-c0e919e13ec1	0	20	f	\N	\N
811dab95-4a69-4bbf-80fe-20d6aa61fb7b	\N	\N	master	be4ed342-4806-499d-a3ca-c0e919e13ec1	1	30	t	162d6d85-d8a6-4c85-928b-664a55b951a6	\N
235357bc-b8dc-4fbe-84af-ef06d3452bd1	\N	conditional-user-configured	master	162d6d85-d8a6-4c85-928b-664a55b951a6	0	10	f	\N	\N
172703d6-83c9-4a0a-b77c-7989eadccbea	\N	direct-grant-validate-otp	master	162d6d85-d8a6-4c85-928b-664a55b951a6	0	20	f	\N	\N
80100eac-2758-4a2f-923c-393d98224a00	\N	registration-page-form	master	d4ddc695-3f86-4806-959e-1fb1ebb72540	0	10	t	cef92192-f29f-44c6-96d8-6a9492ed4cdc	\N
447208a3-8b6f-4c94-9014-401aca6b7837	\N	registration-user-creation	master	cef92192-f29f-44c6-96d8-6a9492ed4cdc	0	20	f	\N	\N
8ae8ea05-24ca-4ccc-b4e9-314edfa78eaa	\N	registration-profile-action	master	cef92192-f29f-44c6-96d8-6a9492ed4cdc	0	40	f	\N	\N
de94ea2e-7dbb-4d5a-b2ab-7f632fb49135	\N	registration-password-action	master	cef92192-f29f-44c6-96d8-6a9492ed4cdc	0	50	f	\N	\N
0a946ef5-eac1-487a-9afe-00603498d7c7	\N	registration-recaptcha-action	master	cef92192-f29f-44c6-96d8-6a9492ed4cdc	3	60	f	\N	\N
e4ec3bf8-5957-4768-b6a3-f32245716a45	\N	reset-credentials-choose-user	master	20abdda5-23b6-49e7-b713-5f6ddbccca9d	0	10	f	\N	\N
b4b6fc56-0e57-488c-9b7e-0c89f59bafeb	\N	reset-credential-email	master	20abdda5-23b6-49e7-b713-5f6ddbccca9d	0	20	f	\N	\N
afef1426-ee55-4d57-981a-68dab04a8556	\N	reset-password	master	20abdda5-23b6-49e7-b713-5f6ddbccca9d	0	30	f	\N	\N
6c6844ea-d54c-4a25-9f07-32eb2f349133	\N	\N	master	20abdda5-23b6-49e7-b713-5f6ddbccca9d	1	40	t	6d26d96e-94fb-45ce-b8e0-4bba9d9cf996	\N
c1dddf6a-355c-4d7e-9d02-3bda891960b6	\N	conditional-user-configured	master	6d26d96e-94fb-45ce-b8e0-4bba9d9cf996	0	10	f	\N	\N
4c282f61-31ed-486a-a3a2-c030d9856818	\N	reset-otp	master	6d26d96e-94fb-45ce-b8e0-4bba9d9cf996	0	20	f	\N	\N
7a12b8a9-6e56-4702-8196-ec6dcff2ccf0	\N	client-secret	master	b6e84c6b-8437-4106-a2c6-915ffc0bd034	2	10	f	\N	\N
75c46d82-4aae-44f2-ac0e-1812a3779905	\N	client-jwt	master	b6e84c6b-8437-4106-a2c6-915ffc0bd034	2	20	f	\N	\N
e4c34ea0-3356-477f-a0eb-bea32f0c63c7	\N	client-secret-jwt	master	b6e84c6b-8437-4106-a2c6-915ffc0bd034	2	30	f	\N	\N
86c3450b-28cb-4e27-97ad-eb4d00ae1f20	\N	client-x509	master	b6e84c6b-8437-4106-a2c6-915ffc0bd034	2	40	f	\N	\N
1a300457-f7e6-4283-843c-35d45eb700ac	\N	idp-review-profile	master	42057ade-d2c0-4045-af21-5ba4308cf118	0	10	f	\N	43d2eb47-39c9-49f6-9504-b5ea7c58e270
e5f32582-92bd-4381-8cc4-ce80b4dcd32d	\N	\N	master	42057ade-d2c0-4045-af21-5ba4308cf118	0	20	t	8cf92f96-25b8-45d8-a503-dc24e829058e	\N
7d3a43ec-c7fb-4b17-b9cb-ca7506029834	\N	idp-create-user-if-unique	master	8cf92f96-25b8-45d8-a503-dc24e829058e	2	10	f	\N	86a2e732-8fc2-4984-b229-7aac9e0fe0d2
ef9d24c5-5624-4c88-824d-bcccf59ac05a	\N	\N	master	8cf92f96-25b8-45d8-a503-dc24e829058e	2	20	t	81dfcbdc-69e8-4f86-b22c-fcb5d2e6e0ae	\N
a5bc4d66-3f04-49df-9ea0-cc8d1a5c09c1	\N	idp-confirm-link	master	81dfcbdc-69e8-4f86-b22c-fcb5d2e6e0ae	0	10	f	\N	\N
8c461c75-012d-4e45-a126-4645d30cf3d1	\N	\N	master	81dfcbdc-69e8-4f86-b22c-fcb5d2e6e0ae	0	20	t	5f9a34c4-d2fc-4d86-93a4-6747e336f095	\N
b0d860bb-c940-42ae-87a7-5025d80c7374	\N	idp-email-verification	master	5f9a34c4-d2fc-4d86-93a4-6747e336f095	2	10	f	\N	\N
65c48fdb-494e-492b-8650-0c780aad572c	\N	\N	master	5f9a34c4-d2fc-4d86-93a4-6747e336f095	2	20	t	b7c3891b-ec54-41bd-ae16-cd4ecfc0fb9b	\N
25f0a4a9-77ac-442c-956b-0f48547850f5	\N	idp-username-password-form	master	b7c3891b-ec54-41bd-ae16-cd4ecfc0fb9b	0	10	f	\N	\N
7aeabbd6-9edf-4965-af27-0bf9c770cd90	\N	\N	master	b7c3891b-ec54-41bd-ae16-cd4ecfc0fb9b	1	20	t	6e4217a6-6377-46ba-9734-e8e9150d4042	\N
86438bf1-f5c4-4650-9a46-422ca0fce8af	\N	conditional-user-configured	master	6e4217a6-6377-46ba-9734-e8e9150d4042	0	10	f	\N	\N
c38c1cb2-6ae0-4435-8c32-e5bc89b6bc35	\N	auth-otp-form	master	6e4217a6-6377-46ba-9734-e8e9150d4042	0	20	f	\N	\N
259ed8e1-9e4c-49da-be86-4af6939127b9	\N	http-basic-authenticator	master	22b4054b-2224-41c3-a7df-652c9b20d1a6	0	10	f	\N	\N
94563361-e47f-44c9-926c-1ca7b6d93a47	\N	docker-http-basic-authenticator	master	1e1a249f-d3b3-4680-9016-3c2467468e8b	0	10	f	\N	\N
b0f67293-b49b-4a8e-bc51-c2f1fc500be4	\N	no-cookie-redirect	master	d06a526e-6fd0-4dbd-86d9-4a21e525dffb	0	10	f	\N	\N
b312949a-f3b7-462b-ab07-ca3973d28439	\N	\N	master	d06a526e-6fd0-4dbd-86d9-4a21e525dffb	0	20	t	e09edb25-ee32-44c7-9aa0-1bccd0747f04	\N
533075e0-6622-4765-9e67-5f3317eca018	\N	basic-auth	master	e09edb25-ee32-44c7-9aa0-1bccd0747f04	0	10	f	\N	\N
18dedcad-9692-43da-9eec-2a3edeabcb54	\N	basic-auth-otp	master	e09edb25-ee32-44c7-9aa0-1bccd0747f04	3	20	f	\N	\N
a0443a74-02d2-4199-98c9-5ce5ae3e4edd	\N	auth-spnego	master	e09edb25-ee32-44c7-9aa0-1bccd0747f04	3	30	f	\N	\N
3e9b8df3-228c-409f-9922-ded0acdb1a8a	\N	auth-cookie	react-marathon	9d853247-9bf0-4821-a737-71b470130d3d	2	10	f	\N	\N
4f2f20a0-3477-46b3-b886-ca69b7a10556	\N	auth-spnego	react-marathon	9d853247-9bf0-4821-a737-71b470130d3d	3	20	f	\N	\N
ca6751db-2b79-47e5-92db-03530a69f7e3	\N	identity-provider-redirector	react-marathon	9d853247-9bf0-4821-a737-71b470130d3d	2	25	f	\N	\N
23299efa-fa4d-45eb-8fe9-dfcf75bfdf4b	\N	\N	react-marathon	9d853247-9bf0-4821-a737-71b470130d3d	2	30	t	c324c223-9bdd-4630-87d9-d7b83d26f0d5	\N
1d9547cc-50f1-477b-a365-67ac490b3dac	\N	auth-username-password-form	react-marathon	c324c223-9bdd-4630-87d9-d7b83d26f0d5	0	10	f	\N	\N
df3c7f3a-98bd-4c38-8f84-fb81e28fd02e	\N	\N	react-marathon	c324c223-9bdd-4630-87d9-d7b83d26f0d5	1	20	t	1a0e882f-181d-4c48-8020-f75d2551b89d	\N
ec2888a6-4872-4888-9b0c-b9a9561e1422	\N	conditional-user-configured	react-marathon	1a0e882f-181d-4c48-8020-f75d2551b89d	0	10	f	\N	\N
c3e46d11-334f-4c1c-a950-a570199677a9	\N	auth-otp-form	react-marathon	1a0e882f-181d-4c48-8020-f75d2551b89d	0	20	f	\N	\N
cdd59fe6-f6eb-4095-bcab-3b211dbcb4ce	\N	direct-grant-validate-username	react-marathon	10992e1a-960e-4991-b715-4767ce0758e3	0	10	f	\N	\N
d69fbbc6-a92e-43bd-8da0-406576f8070b	\N	direct-grant-validate-password	react-marathon	10992e1a-960e-4991-b715-4767ce0758e3	0	20	f	\N	\N
98c70746-e8eb-4024-9071-a534adc83003	\N	\N	react-marathon	10992e1a-960e-4991-b715-4767ce0758e3	1	30	t	3106aa60-c2a8-4baf-8f08-25f7030f1b26	\N
f9ba189b-f356-4888-b514-5aedd709d096	\N	conditional-user-configured	react-marathon	3106aa60-c2a8-4baf-8f08-25f7030f1b26	0	10	f	\N	\N
b25b1714-b1f5-4198-8c08-91738d4b2791	\N	direct-grant-validate-otp	react-marathon	3106aa60-c2a8-4baf-8f08-25f7030f1b26	0	20	f	\N	\N
3ebd718e-0f31-49eb-a9bf-49461ab11ab2	\N	registration-page-form	react-marathon	54b20568-ad9b-4006-a25f-057a4cb74ccb	0	10	t	d422a035-1826-4001-93fe-550f11943c1a	\N
173e6515-f0f3-4541-8ce2-e91f0925a07f	\N	registration-user-creation	react-marathon	d422a035-1826-4001-93fe-550f11943c1a	0	20	f	\N	\N
baf01fa5-d440-407d-a6b8-641aca136c41	\N	registration-profile-action	react-marathon	d422a035-1826-4001-93fe-550f11943c1a	0	40	f	\N	\N
5db7cb88-d4a9-45b7-bc03-1688785b57b7	\N	registration-password-action	react-marathon	d422a035-1826-4001-93fe-550f11943c1a	0	50	f	\N	\N
e672e4a9-067f-419a-8e49-e7e02ce91ad3	\N	registration-recaptcha-action	react-marathon	d422a035-1826-4001-93fe-550f11943c1a	3	60	f	\N	\N
d355ecc5-5a59-402d-890c-067715779696	\N	reset-credentials-choose-user	react-marathon	54b147fe-5ff0-46fa-93db-d0f5c8b67cef	0	10	f	\N	\N
69f0a0e1-cec9-441d-b58c-af8bda50033a	\N	reset-credential-email	react-marathon	54b147fe-5ff0-46fa-93db-d0f5c8b67cef	0	20	f	\N	\N
f5b18587-fd1a-4b4b-a9da-28c0c9e89597	\N	reset-password	react-marathon	54b147fe-5ff0-46fa-93db-d0f5c8b67cef	0	30	f	\N	\N
b56b634e-4c83-423f-8772-08d881e8be0d	\N	\N	react-marathon	54b147fe-5ff0-46fa-93db-d0f5c8b67cef	1	40	t	1d4be183-9236-443c-b6b6-25b995b73f09	\N
6fccaa2f-088f-4c7a-bd82-27ca0e93bea4	\N	conditional-user-configured	react-marathon	1d4be183-9236-443c-b6b6-25b995b73f09	0	10	f	\N	\N
e446b093-f0d4-428e-8316-bf52d3b17f40	\N	reset-otp	react-marathon	1d4be183-9236-443c-b6b6-25b995b73f09	0	20	f	\N	\N
e2c64907-266a-455d-b16f-7e0c67da15e1	\N	client-secret	react-marathon	eb8163a8-a3b0-4bed-8399-bd7cfe1e0d81	2	10	f	\N	\N
e0e7561d-c843-47d5-b8a4-ea7e47ce5fc3	\N	client-jwt	react-marathon	eb8163a8-a3b0-4bed-8399-bd7cfe1e0d81	2	20	f	\N	\N
dec8f77d-0328-461b-bee3-7a7b13f1278a	\N	client-secret-jwt	react-marathon	eb8163a8-a3b0-4bed-8399-bd7cfe1e0d81	2	30	f	\N	\N
14d38d03-cd00-44ce-bf4e-6da1824bb925	\N	client-x509	react-marathon	eb8163a8-a3b0-4bed-8399-bd7cfe1e0d81	2	40	f	\N	\N
d0aaf7c9-d205-4b07-ae22-9de88127d4be	\N	idp-review-profile	react-marathon	e30ae359-57cd-44ae-9910-f35886982005	0	10	f	\N	2c1c7f30-589f-4224-8864-f6dab1d890c7
97ba25c8-7f31-45c0-84a8-e5de4c38bc10	\N	\N	react-marathon	e30ae359-57cd-44ae-9910-f35886982005	0	20	t	0b7067f4-f271-4128-bc17-853821bf2c24	\N
fed5bd9a-d512-4217-8242-2fff9afecb23	\N	idp-create-user-if-unique	react-marathon	0b7067f4-f271-4128-bc17-853821bf2c24	2	10	f	\N	3e697ba5-f609-406f-ac90-6e51d0af5bfe
fe1c846a-53dd-4a75-b7d5-06625afe8156	\N	\N	react-marathon	0b7067f4-f271-4128-bc17-853821bf2c24	2	20	t	d59b95e4-582e-4929-b657-445ede3e52b3	\N
f9e94840-0109-405d-83ab-745c9591370a	\N	idp-confirm-link	react-marathon	d59b95e4-582e-4929-b657-445ede3e52b3	0	10	f	\N	\N
520b170f-87b3-4746-b942-321e2bce9c83	\N	\N	react-marathon	d59b95e4-582e-4929-b657-445ede3e52b3	0	20	t	ce69d470-29a1-4f12-8175-a0a7967cf222	\N
bab87372-bac3-43a8-8626-22b8122f0b7c	\N	idp-email-verification	react-marathon	ce69d470-29a1-4f12-8175-a0a7967cf222	2	10	f	\N	\N
84ecb6b1-c323-4de8-b509-545c3131cbbf	\N	\N	react-marathon	ce69d470-29a1-4f12-8175-a0a7967cf222	2	20	t	135c736b-d949-490e-889d-398003860b7c	\N
a302b7f5-747d-4e92-a31d-c9d188c59543	\N	idp-username-password-form	react-marathon	135c736b-d949-490e-889d-398003860b7c	0	10	f	\N	\N
c0b132c8-6369-4498-9fd4-1c797227dc4f	\N	\N	react-marathon	135c736b-d949-490e-889d-398003860b7c	1	20	t	75e2e2d6-729d-4d2a-9bb9-b8c8a48eee37	\N
b3a66355-d585-44b0-ab51-418c350050cd	\N	conditional-user-configured	react-marathon	75e2e2d6-729d-4d2a-9bb9-b8c8a48eee37	0	10	f	\N	\N
9526cb54-fd0b-4230-afeb-c7be38de4e2a	\N	auth-otp-form	react-marathon	75e2e2d6-729d-4d2a-9bb9-b8c8a48eee37	0	20	f	\N	\N
b04c294d-932e-4830-a16f-cdbf2a33d018	\N	http-basic-authenticator	react-marathon	aa3fa277-1b75-4bd7-ac4f-a6acd2a14ac9	0	10	f	\N	\N
7b6f6212-fd48-42a1-91c0-8d75f3269461	\N	docker-http-basic-authenticator	react-marathon	38340817-d726-46fa-b970-beb6cb616496	0	10	f	\N	\N
ef28c8b6-4561-4ccd-b32c-6d1e09d5751a	\N	no-cookie-redirect	react-marathon	d9c3c6ed-eba7-4ea7-8b9c-cfc1a8f09102	0	10	f	\N	\N
2c6f923a-e520-44be-b6bd-62901f621e51	\N	\N	react-marathon	d9c3c6ed-eba7-4ea7-8b9c-cfc1a8f09102	0	20	t	15656c5a-e90a-4744-94a6-658c975e9602	\N
cc5f466a-b439-416b-bca9-e365c3c08030	\N	basic-auth	react-marathon	15656c5a-e90a-4744-94a6-658c975e9602	0	10	f	\N	\N
2edcaa37-2489-41a7-b59b-f20ab93f29c1	\N	basic-auth-otp	react-marathon	15656c5a-e90a-4744-94a6-658c975e9602	3	20	f	\N	\N
12cfb112-dc0b-4ec4-8c5d-b9e0ad08b136	\N	auth-spnego	react-marathon	15656c5a-e90a-4744-94a6-658c975e9602	3	30	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
19ecbefd-67ac-4f96-bf4e-1d443ac35b0a	browser	browser based authentication	master	basic-flow	t	t
0c77c455-1444-4c9e-a7bf-461754440723	forms	Username, password, otp and other auth forms.	master	basic-flow	f	t
c3d8445a-a486-4e2c-ac04-3406dbe4e10d	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
be4ed342-4806-499d-a3ca-c0e919e13ec1	direct grant	OpenID Connect Resource Owner Grant	master	basic-flow	t	t
162d6d85-d8a6-4c85-928b-664a55b951a6	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
d4ddc695-3f86-4806-959e-1fb1ebb72540	registration	registration flow	master	basic-flow	t	t
cef92192-f29f-44c6-96d8-6a9492ed4cdc	registration form	registration form	master	form-flow	f	t
20abdda5-23b6-49e7-b713-5f6ddbccca9d	reset credentials	Reset credentials for a user if they forgot their password or something	master	basic-flow	t	t
6d26d96e-94fb-45ce-b8e0-4bba9d9cf996	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	master	basic-flow	f	t
b6e84c6b-8437-4106-a2c6-915ffc0bd034	clients	Base authentication for clients	master	client-flow	t	t
42057ade-d2c0-4045-af21-5ba4308cf118	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	master	basic-flow	t	t
8cf92f96-25b8-45d8-a503-dc24e829058e	User creation or linking	Flow for the existing/non-existing user alternatives	master	basic-flow	f	t
81dfcbdc-69e8-4f86-b22c-fcb5d2e6e0ae	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	master	basic-flow	f	t
5f9a34c4-d2fc-4d86-93a4-6747e336f095	Account verification options	Method with which to verity the existing account	master	basic-flow	f	t
b7c3891b-ec54-41bd-ae16-cd4ecfc0fb9b	Verify Existing Account by Re-authentication	Reauthentication of existing account	master	basic-flow	f	t
6e4217a6-6377-46ba-9734-e8e9150d4042	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
22b4054b-2224-41c3-a7df-652c9b20d1a6	saml ecp	SAML ECP Profile Authentication Flow	master	basic-flow	t	t
1e1a249f-d3b3-4680-9016-3c2467468e8b	docker auth	Used by Docker clients to authenticate against the IDP	master	basic-flow	t	t
d06a526e-6fd0-4dbd-86d9-4a21e525dffb	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	master	basic-flow	t	t
e09edb25-ee32-44c7-9aa0-1bccd0747f04	Authentication Options	Authentication options.	master	basic-flow	f	t
9d853247-9bf0-4821-a737-71b470130d3d	browser	browser based authentication	react-marathon	basic-flow	t	t
c324c223-9bdd-4630-87d9-d7b83d26f0d5	forms	Username, password, otp and other auth forms.	react-marathon	basic-flow	f	t
1a0e882f-181d-4c48-8020-f75d2551b89d	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	react-marathon	basic-flow	f	t
10992e1a-960e-4991-b715-4767ce0758e3	direct grant	OpenID Connect Resource Owner Grant	react-marathon	basic-flow	t	t
3106aa60-c2a8-4baf-8f08-25f7030f1b26	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	react-marathon	basic-flow	f	t
54b20568-ad9b-4006-a25f-057a4cb74ccb	registration	registration flow	react-marathon	basic-flow	t	t
d422a035-1826-4001-93fe-550f11943c1a	registration form	registration form	react-marathon	form-flow	f	t
54b147fe-5ff0-46fa-93db-d0f5c8b67cef	reset credentials	Reset credentials for a user if they forgot their password or something	react-marathon	basic-flow	t	t
1d4be183-9236-443c-b6b6-25b995b73f09	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	react-marathon	basic-flow	f	t
eb8163a8-a3b0-4bed-8399-bd7cfe1e0d81	clients	Base authentication for clients	react-marathon	client-flow	t	t
e30ae359-57cd-44ae-9910-f35886982005	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	react-marathon	basic-flow	t	t
0b7067f4-f271-4128-bc17-853821bf2c24	User creation or linking	Flow for the existing/non-existing user alternatives	react-marathon	basic-flow	f	t
d59b95e4-582e-4929-b657-445ede3e52b3	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	react-marathon	basic-flow	f	t
ce69d470-29a1-4f12-8175-a0a7967cf222	Account verification options	Method with which to verity the existing account	react-marathon	basic-flow	f	t
135c736b-d949-490e-889d-398003860b7c	Verify Existing Account by Re-authentication	Reauthentication of existing account	react-marathon	basic-flow	f	t
75e2e2d6-729d-4d2a-9bb9-b8c8a48eee37	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	react-marathon	basic-flow	f	t
aa3fa277-1b75-4bd7-ac4f-a6acd2a14ac9	saml ecp	SAML ECP Profile Authentication Flow	react-marathon	basic-flow	t	t
38340817-d726-46fa-b970-beb6cb616496	docker auth	Used by Docker clients to authenticate against the IDP	react-marathon	basic-flow	t	t
d9c3c6ed-eba7-4ea7-8b9c-cfc1a8f09102	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	react-marathon	basic-flow	t	t
15656c5a-e90a-4744-94a6-658c975e9602	Authentication Options	Authentication options.	react-marathon	basic-flow	f	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
43d2eb47-39c9-49f6-9504-b5ea7c58e270	review profile config	master
86a2e732-8fc2-4984-b229-7aac9e0fe0d2	create unique user config	master
2c1c7f30-589f-4224-8864-f6dab1d890c7	review profile config	react-marathon
3e697ba5-f609-406f-ac90-6e51d0af5bfe	create unique user config	react-marathon
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
43d2eb47-39c9-49f6-9504-b5ea7c58e270	missing	update.profile.on.first.login
86a2e732-8fc2-4984-b229-7aac9e0fe0d2	false	require.password.update.after.registration
2c1c7f30-589f-4224-8864-f6dab1d890c7	missing	update.profile.on.first.login
3e697ba5-f609-406f-ac90-6e51d0af5bfe	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
6a8e5601-519e-43be-9442-3db44e3a095d	t	f	master-realm	0	f	\N	\N	t	\N	f	master	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
4d63cc93-ee21-4b8e-93e0-6b0db0612efa	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
e8a8e7cc-5170-46b8-a979-86b100349a5e	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
14cf6353-f9c7-4212-9a4e-6195ab31ac50	t	f	broker	0	f	\N	\N	t	\N	f	master	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
5d8d60cd-2275-4624-a83b-0cc2489052df	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	master	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
d3bc152d-7ab1-482d-b7a3-acc6c31e6f30	t	f	admin-cli	0	t	\N	\N	f	\N	f	master	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
355b9a2d-edda-4f5c-bd91-7a7e59db4f68	t	f	react-marathon-realm	0	f	\N	\N	t	\N	f	master	\N	0	f	f	react-marathon Realm	f	client-secret	\N	\N	\N	t	f	f	f
32ea06f4-2f54-44e8-a08d-ee37835e161e	t	f	realm-management	0	f	\N	\N	t	\N	f	react-marathon	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
72c97257-a124-4449-b005-541f7c4a3f47	t	f	account	0	t	\N	/realms/react-marathon/account/	f	\N	f	react-marathon	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
d0ac1d0b-848b-4beb-8203-7c7ac2ec867b	t	f	account-console	0	t	\N	/realms/react-marathon/account/	f	\N	f	react-marathon	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
454d240b-90b5-4464-ab66-ff684ca7b9f4	t	f	broker	0	f	\N	\N	t	\N	f	react-marathon	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
9a237619-9551-42d8-93d6-2382c2236bd5	t	f	security-admin-console	0	t	\N	/admin/react-marathon/console/	f	\N	f	react-marathon	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
fc24d60e-b4e7-45ec-a2bf-1380a5085bf4	t	f	admin-cli	0	t	\N	\N	f	\N	f	react-marathon	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
4e126d73-3f63-4b81-9d4c-5ceed8e8b535	t	t	react-marathon-app	0	t	\N	\N	f	http://localhost:3000	f	react-marathon	openid-connect	-1	f	f	\N	f	client-secret	http://localhost:3000	\N	\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
e8a8e7cc-5170-46b8-a979-86b100349a5e	S256	pkce.code.challenge.method
5d8d60cd-2275-4624-a83b-0cc2489052df	S256	pkce.code.challenge.method
d0ac1d0b-848b-4beb-8203-7c7ac2ec867b	S256	pkce.code.challenge.method
9a237619-9551-42d8-93d6-2382c2236bd5	S256	pkce.code.challenge.method
4e126d73-3f63-4b81-9d4c-5ceed8e8b535	true	backchannel.logout.session.required
4e126d73-3f63-4b81-9d4c-5ceed8e8b535	false	backchannel.logout.revoke.offline.tokens
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
ac60c68c-6deb-4cd0-84d6-cd27d61a6eb4	offline_access	master	OpenID Connect built-in scope: offline_access	openid-connect
617e1dd5-d57f-479a-b602-bff1fcdce8ec	role_list	master	SAML role list	saml
21d8a424-5f9f-4d92-a39e-f41184e302b5	profile	master	OpenID Connect built-in scope: profile	openid-connect
a281e36b-c8b1-4d2a-8f98-58e72ab04972	email	master	OpenID Connect built-in scope: email	openid-connect
da2e5ac9-dee5-4390-8e75-d818c7aa94c7	address	master	OpenID Connect built-in scope: address	openid-connect
d5264321-1f38-4df7-ae7f-bd48ae833bb5	phone	master	OpenID Connect built-in scope: phone	openid-connect
e3f935c2-99ad-4168-b6a2-232009e34a1f	roles	master	OpenID Connect scope for add user roles to the access token	openid-connect
99f32146-6455-4cdc-96d2-8c3b2d04a7e4	web-origins	master	OpenID Connect scope for add allowed web origins to the access token	openid-connect
76629e6a-d49a-4b9a-9d09-7b80599739bd	microprofile-jwt	master	Microprofile - JWT built-in scope	openid-connect
69852b21-f51f-423c-884a-c36689effca5	offline_access	react-marathon	OpenID Connect built-in scope: offline_access	openid-connect
425ae237-7da9-42fa-a319-c52cacd05960	role_list	react-marathon	SAML role list	saml
b31ae683-a5d1-4c64-8b30-d8abbd312a62	profile	react-marathon	OpenID Connect built-in scope: profile	openid-connect
8c5557f8-d97a-492e-b96a-bedbf6dc1d1c	email	react-marathon	OpenID Connect built-in scope: email	openid-connect
d86d775c-eeb8-474c-b0aa-c2e97fc690b2	address	react-marathon	OpenID Connect built-in scope: address	openid-connect
4ebf94d3-d087-41a2-aec1-0b08d8d63a28	phone	react-marathon	OpenID Connect built-in scope: phone	openid-connect
32d54869-14fa-4e24-825d-531a61f0d28d	roles	react-marathon	OpenID Connect scope for add user roles to the access token	openid-connect
6fbcf08a-9fbc-4ae1-bb30-d0b07894cd87	web-origins	react-marathon	OpenID Connect scope for add allowed web origins to the access token	openid-connect
e7cb4ef1-52e8-43e9-92ad-c45171fe5486	microprofile-jwt	react-marathon	Microprofile - JWT built-in scope	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
ac60c68c-6deb-4cd0-84d6-cd27d61a6eb4	true	display.on.consent.screen
ac60c68c-6deb-4cd0-84d6-cd27d61a6eb4	${offlineAccessScopeConsentText}	consent.screen.text
617e1dd5-d57f-479a-b602-bff1fcdce8ec	true	display.on.consent.screen
617e1dd5-d57f-479a-b602-bff1fcdce8ec	${samlRoleListScopeConsentText}	consent.screen.text
21d8a424-5f9f-4d92-a39e-f41184e302b5	true	display.on.consent.screen
21d8a424-5f9f-4d92-a39e-f41184e302b5	${profileScopeConsentText}	consent.screen.text
21d8a424-5f9f-4d92-a39e-f41184e302b5	true	include.in.token.scope
a281e36b-c8b1-4d2a-8f98-58e72ab04972	true	display.on.consent.screen
a281e36b-c8b1-4d2a-8f98-58e72ab04972	${emailScopeConsentText}	consent.screen.text
a281e36b-c8b1-4d2a-8f98-58e72ab04972	true	include.in.token.scope
da2e5ac9-dee5-4390-8e75-d818c7aa94c7	true	display.on.consent.screen
da2e5ac9-dee5-4390-8e75-d818c7aa94c7	${addressScopeConsentText}	consent.screen.text
da2e5ac9-dee5-4390-8e75-d818c7aa94c7	true	include.in.token.scope
d5264321-1f38-4df7-ae7f-bd48ae833bb5	true	display.on.consent.screen
d5264321-1f38-4df7-ae7f-bd48ae833bb5	${phoneScopeConsentText}	consent.screen.text
d5264321-1f38-4df7-ae7f-bd48ae833bb5	true	include.in.token.scope
e3f935c2-99ad-4168-b6a2-232009e34a1f	true	display.on.consent.screen
e3f935c2-99ad-4168-b6a2-232009e34a1f	${rolesScopeConsentText}	consent.screen.text
e3f935c2-99ad-4168-b6a2-232009e34a1f	false	include.in.token.scope
99f32146-6455-4cdc-96d2-8c3b2d04a7e4	false	display.on.consent.screen
99f32146-6455-4cdc-96d2-8c3b2d04a7e4		consent.screen.text
99f32146-6455-4cdc-96d2-8c3b2d04a7e4	false	include.in.token.scope
76629e6a-d49a-4b9a-9d09-7b80599739bd	false	display.on.consent.screen
76629e6a-d49a-4b9a-9d09-7b80599739bd	true	include.in.token.scope
69852b21-f51f-423c-884a-c36689effca5	true	display.on.consent.screen
69852b21-f51f-423c-884a-c36689effca5	${offlineAccessScopeConsentText}	consent.screen.text
425ae237-7da9-42fa-a319-c52cacd05960	true	display.on.consent.screen
425ae237-7da9-42fa-a319-c52cacd05960	${samlRoleListScopeConsentText}	consent.screen.text
b31ae683-a5d1-4c64-8b30-d8abbd312a62	true	display.on.consent.screen
b31ae683-a5d1-4c64-8b30-d8abbd312a62	${profileScopeConsentText}	consent.screen.text
b31ae683-a5d1-4c64-8b30-d8abbd312a62	true	include.in.token.scope
8c5557f8-d97a-492e-b96a-bedbf6dc1d1c	true	display.on.consent.screen
8c5557f8-d97a-492e-b96a-bedbf6dc1d1c	${emailScopeConsentText}	consent.screen.text
8c5557f8-d97a-492e-b96a-bedbf6dc1d1c	true	include.in.token.scope
d86d775c-eeb8-474c-b0aa-c2e97fc690b2	true	display.on.consent.screen
d86d775c-eeb8-474c-b0aa-c2e97fc690b2	${addressScopeConsentText}	consent.screen.text
d86d775c-eeb8-474c-b0aa-c2e97fc690b2	true	include.in.token.scope
4ebf94d3-d087-41a2-aec1-0b08d8d63a28	true	display.on.consent.screen
4ebf94d3-d087-41a2-aec1-0b08d8d63a28	${phoneScopeConsentText}	consent.screen.text
4ebf94d3-d087-41a2-aec1-0b08d8d63a28	true	include.in.token.scope
32d54869-14fa-4e24-825d-531a61f0d28d	true	display.on.consent.screen
32d54869-14fa-4e24-825d-531a61f0d28d	${rolesScopeConsentText}	consent.screen.text
32d54869-14fa-4e24-825d-531a61f0d28d	false	include.in.token.scope
6fbcf08a-9fbc-4ae1-bb30-d0b07894cd87	false	display.on.consent.screen
6fbcf08a-9fbc-4ae1-bb30-d0b07894cd87		consent.screen.text
6fbcf08a-9fbc-4ae1-bb30-d0b07894cd87	false	include.in.token.scope
e7cb4ef1-52e8-43e9-92ad-c45171fe5486	false	display.on.consent.screen
e7cb4ef1-52e8-43e9-92ad-c45171fe5486	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
4d63cc93-ee21-4b8e-93e0-6b0db0612efa	e3f935c2-99ad-4168-b6a2-232009e34a1f	t
4d63cc93-ee21-4b8e-93e0-6b0db0612efa	21d8a424-5f9f-4d92-a39e-f41184e302b5	t
4d63cc93-ee21-4b8e-93e0-6b0db0612efa	99f32146-6455-4cdc-96d2-8c3b2d04a7e4	t
4d63cc93-ee21-4b8e-93e0-6b0db0612efa	a281e36b-c8b1-4d2a-8f98-58e72ab04972	t
4d63cc93-ee21-4b8e-93e0-6b0db0612efa	76629e6a-d49a-4b9a-9d09-7b80599739bd	f
4d63cc93-ee21-4b8e-93e0-6b0db0612efa	da2e5ac9-dee5-4390-8e75-d818c7aa94c7	f
4d63cc93-ee21-4b8e-93e0-6b0db0612efa	ac60c68c-6deb-4cd0-84d6-cd27d61a6eb4	f
4d63cc93-ee21-4b8e-93e0-6b0db0612efa	d5264321-1f38-4df7-ae7f-bd48ae833bb5	f
e8a8e7cc-5170-46b8-a979-86b100349a5e	e3f935c2-99ad-4168-b6a2-232009e34a1f	t
e8a8e7cc-5170-46b8-a979-86b100349a5e	21d8a424-5f9f-4d92-a39e-f41184e302b5	t
e8a8e7cc-5170-46b8-a979-86b100349a5e	99f32146-6455-4cdc-96d2-8c3b2d04a7e4	t
e8a8e7cc-5170-46b8-a979-86b100349a5e	a281e36b-c8b1-4d2a-8f98-58e72ab04972	t
e8a8e7cc-5170-46b8-a979-86b100349a5e	76629e6a-d49a-4b9a-9d09-7b80599739bd	f
e8a8e7cc-5170-46b8-a979-86b100349a5e	da2e5ac9-dee5-4390-8e75-d818c7aa94c7	f
e8a8e7cc-5170-46b8-a979-86b100349a5e	ac60c68c-6deb-4cd0-84d6-cd27d61a6eb4	f
e8a8e7cc-5170-46b8-a979-86b100349a5e	d5264321-1f38-4df7-ae7f-bd48ae833bb5	f
d3bc152d-7ab1-482d-b7a3-acc6c31e6f30	e3f935c2-99ad-4168-b6a2-232009e34a1f	t
d3bc152d-7ab1-482d-b7a3-acc6c31e6f30	21d8a424-5f9f-4d92-a39e-f41184e302b5	t
d3bc152d-7ab1-482d-b7a3-acc6c31e6f30	99f32146-6455-4cdc-96d2-8c3b2d04a7e4	t
d3bc152d-7ab1-482d-b7a3-acc6c31e6f30	a281e36b-c8b1-4d2a-8f98-58e72ab04972	t
d3bc152d-7ab1-482d-b7a3-acc6c31e6f30	76629e6a-d49a-4b9a-9d09-7b80599739bd	f
d3bc152d-7ab1-482d-b7a3-acc6c31e6f30	da2e5ac9-dee5-4390-8e75-d818c7aa94c7	f
d3bc152d-7ab1-482d-b7a3-acc6c31e6f30	ac60c68c-6deb-4cd0-84d6-cd27d61a6eb4	f
d3bc152d-7ab1-482d-b7a3-acc6c31e6f30	d5264321-1f38-4df7-ae7f-bd48ae833bb5	f
14cf6353-f9c7-4212-9a4e-6195ab31ac50	e3f935c2-99ad-4168-b6a2-232009e34a1f	t
14cf6353-f9c7-4212-9a4e-6195ab31ac50	21d8a424-5f9f-4d92-a39e-f41184e302b5	t
14cf6353-f9c7-4212-9a4e-6195ab31ac50	99f32146-6455-4cdc-96d2-8c3b2d04a7e4	t
14cf6353-f9c7-4212-9a4e-6195ab31ac50	a281e36b-c8b1-4d2a-8f98-58e72ab04972	t
14cf6353-f9c7-4212-9a4e-6195ab31ac50	76629e6a-d49a-4b9a-9d09-7b80599739bd	f
14cf6353-f9c7-4212-9a4e-6195ab31ac50	da2e5ac9-dee5-4390-8e75-d818c7aa94c7	f
14cf6353-f9c7-4212-9a4e-6195ab31ac50	ac60c68c-6deb-4cd0-84d6-cd27d61a6eb4	f
14cf6353-f9c7-4212-9a4e-6195ab31ac50	d5264321-1f38-4df7-ae7f-bd48ae833bb5	f
6a8e5601-519e-43be-9442-3db44e3a095d	e3f935c2-99ad-4168-b6a2-232009e34a1f	t
6a8e5601-519e-43be-9442-3db44e3a095d	21d8a424-5f9f-4d92-a39e-f41184e302b5	t
6a8e5601-519e-43be-9442-3db44e3a095d	99f32146-6455-4cdc-96d2-8c3b2d04a7e4	t
6a8e5601-519e-43be-9442-3db44e3a095d	a281e36b-c8b1-4d2a-8f98-58e72ab04972	t
6a8e5601-519e-43be-9442-3db44e3a095d	76629e6a-d49a-4b9a-9d09-7b80599739bd	f
6a8e5601-519e-43be-9442-3db44e3a095d	da2e5ac9-dee5-4390-8e75-d818c7aa94c7	f
6a8e5601-519e-43be-9442-3db44e3a095d	ac60c68c-6deb-4cd0-84d6-cd27d61a6eb4	f
6a8e5601-519e-43be-9442-3db44e3a095d	d5264321-1f38-4df7-ae7f-bd48ae833bb5	f
5d8d60cd-2275-4624-a83b-0cc2489052df	e3f935c2-99ad-4168-b6a2-232009e34a1f	t
5d8d60cd-2275-4624-a83b-0cc2489052df	21d8a424-5f9f-4d92-a39e-f41184e302b5	t
5d8d60cd-2275-4624-a83b-0cc2489052df	99f32146-6455-4cdc-96d2-8c3b2d04a7e4	t
5d8d60cd-2275-4624-a83b-0cc2489052df	a281e36b-c8b1-4d2a-8f98-58e72ab04972	t
5d8d60cd-2275-4624-a83b-0cc2489052df	76629e6a-d49a-4b9a-9d09-7b80599739bd	f
5d8d60cd-2275-4624-a83b-0cc2489052df	da2e5ac9-dee5-4390-8e75-d818c7aa94c7	f
5d8d60cd-2275-4624-a83b-0cc2489052df	ac60c68c-6deb-4cd0-84d6-cd27d61a6eb4	f
5d8d60cd-2275-4624-a83b-0cc2489052df	d5264321-1f38-4df7-ae7f-bd48ae833bb5	f
72c97257-a124-4449-b005-541f7c4a3f47	8c5557f8-d97a-492e-b96a-bedbf6dc1d1c	t
72c97257-a124-4449-b005-541f7c4a3f47	32d54869-14fa-4e24-825d-531a61f0d28d	t
72c97257-a124-4449-b005-541f7c4a3f47	b31ae683-a5d1-4c64-8b30-d8abbd312a62	t
72c97257-a124-4449-b005-541f7c4a3f47	6fbcf08a-9fbc-4ae1-bb30-d0b07894cd87	t
72c97257-a124-4449-b005-541f7c4a3f47	4ebf94d3-d087-41a2-aec1-0b08d8d63a28	f
72c97257-a124-4449-b005-541f7c4a3f47	e7cb4ef1-52e8-43e9-92ad-c45171fe5486	f
72c97257-a124-4449-b005-541f7c4a3f47	d86d775c-eeb8-474c-b0aa-c2e97fc690b2	f
72c97257-a124-4449-b005-541f7c4a3f47	69852b21-f51f-423c-884a-c36689effca5	f
d0ac1d0b-848b-4beb-8203-7c7ac2ec867b	8c5557f8-d97a-492e-b96a-bedbf6dc1d1c	t
d0ac1d0b-848b-4beb-8203-7c7ac2ec867b	32d54869-14fa-4e24-825d-531a61f0d28d	t
d0ac1d0b-848b-4beb-8203-7c7ac2ec867b	b31ae683-a5d1-4c64-8b30-d8abbd312a62	t
d0ac1d0b-848b-4beb-8203-7c7ac2ec867b	6fbcf08a-9fbc-4ae1-bb30-d0b07894cd87	t
d0ac1d0b-848b-4beb-8203-7c7ac2ec867b	4ebf94d3-d087-41a2-aec1-0b08d8d63a28	f
d0ac1d0b-848b-4beb-8203-7c7ac2ec867b	e7cb4ef1-52e8-43e9-92ad-c45171fe5486	f
d0ac1d0b-848b-4beb-8203-7c7ac2ec867b	d86d775c-eeb8-474c-b0aa-c2e97fc690b2	f
d0ac1d0b-848b-4beb-8203-7c7ac2ec867b	69852b21-f51f-423c-884a-c36689effca5	f
fc24d60e-b4e7-45ec-a2bf-1380a5085bf4	8c5557f8-d97a-492e-b96a-bedbf6dc1d1c	t
fc24d60e-b4e7-45ec-a2bf-1380a5085bf4	32d54869-14fa-4e24-825d-531a61f0d28d	t
fc24d60e-b4e7-45ec-a2bf-1380a5085bf4	b31ae683-a5d1-4c64-8b30-d8abbd312a62	t
fc24d60e-b4e7-45ec-a2bf-1380a5085bf4	6fbcf08a-9fbc-4ae1-bb30-d0b07894cd87	t
fc24d60e-b4e7-45ec-a2bf-1380a5085bf4	4ebf94d3-d087-41a2-aec1-0b08d8d63a28	f
fc24d60e-b4e7-45ec-a2bf-1380a5085bf4	e7cb4ef1-52e8-43e9-92ad-c45171fe5486	f
fc24d60e-b4e7-45ec-a2bf-1380a5085bf4	d86d775c-eeb8-474c-b0aa-c2e97fc690b2	f
fc24d60e-b4e7-45ec-a2bf-1380a5085bf4	69852b21-f51f-423c-884a-c36689effca5	f
454d240b-90b5-4464-ab66-ff684ca7b9f4	8c5557f8-d97a-492e-b96a-bedbf6dc1d1c	t
454d240b-90b5-4464-ab66-ff684ca7b9f4	32d54869-14fa-4e24-825d-531a61f0d28d	t
454d240b-90b5-4464-ab66-ff684ca7b9f4	b31ae683-a5d1-4c64-8b30-d8abbd312a62	t
454d240b-90b5-4464-ab66-ff684ca7b9f4	6fbcf08a-9fbc-4ae1-bb30-d0b07894cd87	t
454d240b-90b5-4464-ab66-ff684ca7b9f4	4ebf94d3-d087-41a2-aec1-0b08d8d63a28	f
454d240b-90b5-4464-ab66-ff684ca7b9f4	e7cb4ef1-52e8-43e9-92ad-c45171fe5486	f
454d240b-90b5-4464-ab66-ff684ca7b9f4	d86d775c-eeb8-474c-b0aa-c2e97fc690b2	f
454d240b-90b5-4464-ab66-ff684ca7b9f4	69852b21-f51f-423c-884a-c36689effca5	f
32ea06f4-2f54-44e8-a08d-ee37835e161e	8c5557f8-d97a-492e-b96a-bedbf6dc1d1c	t
32ea06f4-2f54-44e8-a08d-ee37835e161e	32d54869-14fa-4e24-825d-531a61f0d28d	t
32ea06f4-2f54-44e8-a08d-ee37835e161e	b31ae683-a5d1-4c64-8b30-d8abbd312a62	t
32ea06f4-2f54-44e8-a08d-ee37835e161e	6fbcf08a-9fbc-4ae1-bb30-d0b07894cd87	t
32ea06f4-2f54-44e8-a08d-ee37835e161e	4ebf94d3-d087-41a2-aec1-0b08d8d63a28	f
32ea06f4-2f54-44e8-a08d-ee37835e161e	e7cb4ef1-52e8-43e9-92ad-c45171fe5486	f
32ea06f4-2f54-44e8-a08d-ee37835e161e	d86d775c-eeb8-474c-b0aa-c2e97fc690b2	f
32ea06f4-2f54-44e8-a08d-ee37835e161e	69852b21-f51f-423c-884a-c36689effca5	f
9a237619-9551-42d8-93d6-2382c2236bd5	8c5557f8-d97a-492e-b96a-bedbf6dc1d1c	t
9a237619-9551-42d8-93d6-2382c2236bd5	32d54869-14fa-4e24-825d-531a61f0d28d	t
9a237619-9551-42d8-93d6-2382c2236bd5	b31ae683-a5d1-4c64-8b30-d8abbd312a62	t
9a237619-9551-42d8-93d6-2382c2236bd5	6fbcf08a-9fbc-4ae1-bb30-d0b07894cd87	t
9a237619-9551-42d8-93d6-2382c2236bd5	4ebf94d3-d087-41a2-aec1-0b08d8d63a28	f
9a237619-9551-42d8-93d6-2382c2236bd5	e7cb4ef1-52e8-43e9-92ad-c45171fe5486	f
9a237619-9551-42d8-93d6-2382c2236bd5	d86d775c-eeb8-474c-b0aa-c2e97fc690b2	f
9a237619-9551-42d8-93d6-2382c2236bd5	69852b21-f51f-423c-884a-c36689effca5	f
4e126d73-3f63-4b81-9d4c-5ceed8e8b535	8c5557f8-d97a-492e-b96a-bedbf6dc1d1c	t
4e126d73-3f63-4b81-9d4c-5ceed8e8b535	32d54869-14fa-4e24-825d-531a61f0d28d	t
4e126d73-3f63-4b81-9d4c-5ceed8e8b535	b31ae683-a5d1-4c64-8b30-d8abbd312a62	t
4e126d73-3f63-4b81-9d4c-5ceed8e8b535	6fbcf08a-9fbc-4ae1-bb30-d0b07894cd87	t
4e126d73-3f63-4b81-9d4c-5ceed8e8b535	4ebf94d3-d087-41a2-aec1-0b08d8d63a28	f
4e126d73-3f63-4b81-9d4c-5ceed8e8b535	e7cb4ef1-52e8-43e9-92ad-c45171fe5486	f
4e126d73-3f63-4b81-9d4c-5ceed8e8b535	d86d775c-eeb8-474c-b0aa-c2e97fc690b2	f
4e126d73-3f63-4b81-9d4c-5ceed8e8b535	69852b21-f51f-423c-884a-c36689effca5	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
ac60c68c-6deb-4cd0-84d6-cd27d61a6eb4	1ed40bcd-384c-4228-9af8-59f3cd67d87c
69852b21-f51f-423c-884a-c36689effca5	8b25c2be-145c-4015-96d1-639ea689d2aa
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
c886a995-046f-4bca-99b3-43c839144583	Trusted Hosts	master	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
8866e6fe-f80d-473a-af99-06fb196eee99	Consent Required	master	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
d4fb5114-48af-413a-bca3-6351dbbd76d8	Full Scope Disabled	master	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
17d1dd14-34e7-40a7-ae1a-c077308cb29e	Max Clients Limit	master	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
a4147f45-3e7c-45f1-b19e-f32707f341c0	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
7bdf10f3-08fe-47ef-9f3e-138c18aca52b	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
7afe255b-77da-4883-8e35-549caaa56653	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
eb9a6963-f161-4c0f-8d58-efaa2f7fc0ef	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
5c3e9aa1-819e-45aa-8ef0-a9708edc3c6e	rsa-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
ee1a9c63-9a94-4568-8f09-9dc62fb19385	rsa-enc-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
6abd58c1-4e0a-47f7-80b7-1253fd0eef6f	hmac-generated	master	hmac-generated	org.keycloak.keys.KeyProvider	master	\N
159f3dfa-9fcc-4978-80b8-ed3e12ece97f	aes-generated	master	aes-generated	org.keycloak.keys.KeyProvider	master	\N
901c7921-9331-4710-a120-08d787182770	rsa-generated	react-marathon	rsa-generated	org.keycloak.keys.KeyProvider	react-marathon	\N
995bb5b5-7ef1-47ad-98a5-1cfb1735907f	rsa-enc-generated	react-marathon	rsa-generated	org.keycloak.keys.KeyProvider	react-marathon	\N
0ece05ec-19e8-4cd3-8ed6-27a1bc6e26eb	hmac-generated	react-marathon	hmac-generated	org.keycloak.keys.KeyProvider	react-marathon	\N
ee79bb03-f070-4ff2-ae7d-fd92ef125d19	aes-generated	react-marathon	aes-generated	org.keycloak.keys.KeyProvider	react-marathon	\N
b2d8e390-435c-4d23-a66d-1ef944ee85e3	Trusted Hosts	react-marathon	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	react-marathon	anonymous
af5b4c70-bbc2-49c4-a2fa-95c272d71651	Consent Required	react-marathon	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	react-marathon	anonymous
dadc0a10-14d7-443a-96e1-c307a39f6778	Full Scope Disabled	react-marathon	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	react-marathon	anonymous
3495aae0-0524-49d5-8ede-f5435316267b	Max Clients Limit	react-marathon	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	react-marathon	anonymous
c28b5f2d-9807-46d5-9bfc-bc40017eb1fa	Allowed Protocol Mapper Types	react-marathon	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	react-marathon	anonymous
1b6c4a23-09b5-4224-a631-401227a3e213	Allowed Client Scopes	react-marathon	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	react-marathon	anonymous
b853eeee-82fd-4b9d-9671-f2fa3e265dfd	Allowed Protocol Mapper Types	react-marathon	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	react-marathon	authenticated
b6f78a3b-baf3-40a0-8456-50951c159714	Allowed Client Scopes	react-marathon	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	react-marathon	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
0eead6a0-f4fd-4f55-aa4b-1bcc299c9852	7bdf10f3-08fe-47ef-9f3e-138c18aca52b	allow-default-scopes	true
59bd5329-9dde-40a2-a85f-236e9c0fbb04	7afe255b-77da-4883-8e35-549caaa56653	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
4cebd849-f0a5-4e56-8dee-aba6a8bd900c	7afe255b-77da-4883-8e35-549caaa56653	allowed-protocol-mapper-types	saml-user-property-mapper
c6e284f8-092c-4292-86b4-2a3eab663f57	7afe255b-77da-4883-8e35-549caaa56653	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
0a74adbe-8f3e-4d51-9914-cfbe72eff3c8	7afe255b-77da-4883-8e35-549caaa56653	allowed-protocol-mapper-types	saml-user-attribute-mapper
a4a6ca7a-fd7e-4de1-b82b-5b47f22d2333	7afe255b-77da-4883-8e35-549caaa56653	allowed-protocol-mapper-types	oidc-address-mapper
567dbbce-6be4-480f-99c8-ab06cb65a170	7afe255b-77da-4883-8e35-549caaa56653	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
549cd150-face-4225-99ff-2d4f7bdc3b9c	7afe255b-77da-4883-8e35-549caaa56653	allowed-protocol-mapper-types	oidc-full-name-mapper
9dedaf79-f4d4-45e0-8e14-a48799eb0ff0	7afe255b-77da-4883-8e35-549caaa56653	allowed-protocol-mapper-types	saml-role-list-mapper
fba86f9c-499c-4686-8995-01fb312551f1	c886a995-046f-4bca-99b3-43c839144583	host-sending-registration-request-must-match	true
3f3623d0-c83f-4a7c-8314-1562df4acfe3	c886a995-046f-4bca-99b3-43c839144583	client-uris-must-match	true
62ca5265-030d-40d1-b0af-ec456c278b3c	a4147f45-3e7c-45f1-b19e-f32707f341c0	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
c85b2762-69bc-480f-bd66-6e785a3102f0	a4147f45-3e7c-45f1-b19e-f32707f341c0	allowed-protocol-mapper-types	oidc-full-name-mapper
7dd67ffe-4326-45e1-afc1-6955d1feecf2	a4147f45-3e7c-45f1-b19e-f32707f341c0	allowed-protocol-mapper-types	oidc-address-mapper
2cf21c15-4a80-4671-b0ce-ce51865e474c	a4147f45-3e7c-45f1-b19e-f32707f341c0	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
249bf92d-a836-4417-a4e8-ef350f6c29eb	a4147f45-3e7c-45f1-b19e-f32707f341c0	allowed-protocol-mapper-types	saml-role-list-mapper
51212621-81a4-4699-b5fc-3ca59f31b6e5	a4147f45-3e7c-45f1-b19e-f32707f341c0	allowed-protocol-mapper-types	saml-user-attribute-mapper
fb1ba22e-aa41-4633-9bea-2c25328f249a	a4147f45-3e7c-45f1-b19e-f32707f341c0	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
a771d285-0b06-4d8a-a29a-914d7ee25362	a4147f45-3e7c-45f1-b19e-f32707f341c0	allowed-protocol-mapper-types	saml-user-property-mapper
5aa38f6f-8d52-4062-8eb1-b3e52a78ab73	eb9a6963-f161-4c0f-8d58-efaa2f7fc0ef	allow-default-scopes	true
a92b3a09-3639-4d28-b2cc-ce31b07b4cc7	17d1dd14-34e7-40a7-ae1a-c077308cb29e	max-clients	200
1a591305-9f1f-4926-8b57-bf3aef9c2bc9	159f3dfa-9fcc-4978-80b8-ed3e12ece97f	kid	0add36d5-e82b-41ac-892d-360ffed39b6d
6d0d5f5c-e939-4cd3-998b-17523873a0d4	159f3dfa-9fcc-4978-80b8-ed3e12ece97f	priority	100
5cd56cb1-2b6b-4e00-b162-9e4e382a41e2	159f3dfa-9fcc-4978-80b8-ed3e12ece97f	secret	1dRPDDRAD0f2XqgnZqUrVw
cfa00931-5ef8-47a0-9195-7217803a8d25	ee1a9c63-9a94-4568-8f09-9dc62fb19385	privateKey	MIIEpAIBAAKCAQEAlf8Ij/pybn8LKV6V6ieKiyoEWaBWkJP5vMIEcpa2KusCOO1ElzpfdEqsWeqPNwmHoNh5TahZNCY4xPdw3WcmuHkUFyRWk9slkbgPvs+UDCoOUu8POHbPOgCTOU6Y0OzJARTe8DFg5raDPx+teAFop6+5GcykESJrCdR9ZkKyWCS+7UpCbUAQ18yIxK2Ftcg1rBg7ymX94U73nW0P/1jiiKfswZVHV/5bPX8kxLnH17jwBeaQUVHmSl0XmkQe2rbIQyI7h2TkHlSpTcTZ8zXIO4X5jMI1GWlduu/KMT8kqnfzcYl+gpOraw+c1nZpF3Cj3NgdLGVenW3VfCY1VI4FlQIDAQABAoIBAHQN7n8P5QgPbgBlOZMBYxWHvfPmtfOJOppMd4p9h5cvW/nVwtNLi917hVzQulx4GCNgOoLWdaZ+yD/Fv+LeU7w5mkzJhd9CmQ/lHPGixEahJ5INe3ZRnsae+UpGwMAt5NvcXR305qe7oVLu3JXUaTgNIyeOCYdkXPMvIJNFmZ3OJTN3Kh8/S3kU/o4YUmmQeWskmNxfTFv+pexVfpmUyTgWKQJvY3xyriOkscVxBhxs00tMNpBlxZdlVJVIzUUkeU/yhFixUnWwsctg2v6EbnYYL/aLiibk9fo4uSqIPIlDN3eij64953YptQA2GXDRQ8CWrRSwML9AUYwShUWBZcECgYEA5zNHWXAi2dhhvemXVLydF0JLkTlMs0hBtGeUHyLIUVpOdWJQEE8izpVmHEThmffebo6lvHD+Y69jfrWkwyK8I3v/c+2h2NSzcp7MCZ3Jz2llFZUk3LmBxiBWbef/doaZcahwHopNVL4AsewOZStVQ1074J0/kY9lqZMKIga4ANECgYEAphXnhLdVy8ndOeEgHUOcXUPwmi8np/NFPfHZwQfYMqV8FtWp0voaz4YcgnVCL+q2owIY/V9u9aRn/Dn47tnFTs2MZ8BtA9SsPMGwW/n2yJ56V24seEjjMMH4O2iEkCtFjO8CTmGmyKIJSuukiOiA88CJ0NrzgnMA+7rNrxGaSYUCgYEAtGEKipn1ZtbuMxgbLE5XlXzwriXxVHLMaG7jXoNpnCcDzYtdgcvsERb4apfHF7QOQ11hqyrRHn8I9iPLnz7rYBfvDshYnG4ebw+7iskjWYIWDoelEdxdhnFWXTtC0XtkHgvXJcyrVrFCo43TEVWEmSEVhUHKBcvF+k4w+qkZR/ECgYBoVYZVVx6soKk6/PPBroGCDXYOReUxmp865L2Yh6cHWfH0HlFK2hcRmvw58BOeKmKFUIIGWXdJFPjF+F0rHt7WPEYhvz48k9OHb12sygB/0x6j4fBJt/AQ5ylbmLL+JlDQ0iyutKWjkDcqO5Hm97haZ++rpoAmyLwrZxRjEDnOSQKBgQCxG0nLhcDkezZN6rnoChrDJwaciVYGDi3H/e+FsWm/OEcVxHxZAJI6Vq+7rwxb+/oU6GMoymev4y3B+ik78/JPFJPKKSsYS9cJxkGiHvO9hCea2mo+n2W+j6s1xs7DspI2Z2pMxBR/jtMAOhj3a8aM2Ry/vGHV0iBOD4K6XW2TvQ==
2c0cea40-9c6a-4c5a-bf77-3b8506f500d8	ee1a9c63-9a94-4568-8f09-9dc62fb19385	priority	100
9e9caf38-388c-4012-99cf-3891f0ab9b80	ee1a9c63-9a94-4568-8f09-9dc62fb19385	keyUse	enc
917378c7-4533-4f90-85e7-1a77634f3df4	ee1a9c63-9a94-4568-8f09-9dc62fb19385	certificate	MIICmzCCAYMCBgF8h+J/XTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjExMDE2MDY1NDAwWhcNMzExMDE2MDY1NTQwWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCV/wiP+nJufwspXpXqJ4qLKgRZoFaQk/m8wgRylrYq6wI47USXOl90SqxZ6o83CYeg2HlNqFk0JjjE93DdZya4eRQXJFaT2yWRuA++z5QMKg5S7w84ds86AJM5TpjQ7MkBFN7wMWDmtoM/H614AWinr7kZzKQRImsJ1H1mQrJYJL7tSkJtQBDXzIjErYW1yDWsGDvKZf3hTvedbQ//WOKIp+zBlUdX/ls9fyTEucfXuPAF5pBRUeZKXReaRB7atshDIjuHZOQeVKlNxNnzNcg7hfmMwjUZaV2678oxPySqd/NxiX6Ck6trD5zWdmkXcKPc2B0sZV6dbdV8JjVUjgWVAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAApgFlHka/e9p9o0WZuurYmVd0xIqab09NdmIXGneqMf2BnN8xn8Me9m+Xb74ONg1PKW1J27kFHdGuJ/i368Lf9w5xsN5xb1Tdl+jBLsGn8wE5S/ElZijqfnW5t/qLs8yPrfuRmL2C7idoK1XkcgdZemXv+HKeDlSaDnl2uE19JZMtqv1vYCXq8w8IQo7+KOaHldzIBe5l7dG+bt5dEF4SAzSg/pHrLp+NKamOzV+dHxNOsxURw2wD/Lg219fjljR2r+zXSiP2avbjmkJnCSMbp+DfEkRly8WUGZD2JosJFiJRQG7mrOrxzjH90P4IDOEbEP15itgoMiIp9HCr2T7IE=
cc3dd6a2-e181-40d3-8f3a-2a06bc0a969b	6abd58c1-4e0a-47f7-80b7-1253fd0eef6f	algorithm	HS256
20b4ed21-f2b0-432e-82a0-e88c1ec82508	6abd58c1-4e0a-47f7-80b7-1253fd0eef6f	kid	b0780aee-d413-44cf-8a87-e920309a9935
28b4a027-1f61-4d68-bc76-075bac1c4469	6abd58c1-4e0a-47f7-80b7-1253fd0eef6f	secret	NiLpDrr0zpokVi6zfBhGhFQcUaCI0nrG7TD1_Tc-Y3MNnDhXQHVx4eiiGvSCRkjttBlkaydC9By1hU0BjbGACA
ef4c6d9a-2db3-421d-840b-4ab59a8a296c	6abd58c1-4e0a-47f7-80b7-1253fd0eef6f	priority	100
c20089b5-24cf-47db-b08d-d274536b7e90	5c3e9aa1-819e-45aa-8ef0-a9708edc3c6e	keyUse	sig
784fb454-a34d-45e6-9930-556cf1c8e821	5c3e9aa1-819e-45aa-8ef0-a9708edc3c6e	priority	100
e5ba2c53-ebe5-42e9-a8a4-92d2db1363ff	5c3e9aa1-819e-45aa-8ef0-a9708edc3c6e	privateKey	MIIEpAIBAAKCAQEAlOerZidPwg8Pmjf7znpySomY54jsYuhHOsw6PETvQJdS8NCRtu1uxJFNX79xPoX4u3U8C/gRQyOKfs8CSmW2JKuID0vS6oTdy94DgEGDqTDUCHwGqgklGUvZQ1yp8In6MwNVwRY7O9oN5qkQa1hvM2nzTBzuUVzLE3u2F4eZ1gyKZSHiOZVfWs2R+ecAfSFc57kbFQhl7tLOGik4LcygtjH832KAY8fE6109VJb+PCrOoFiSOtKLNfLVx4SeCwY4APVy45iWW/Ivup8PVR70zggIfBLKwf1zIoL7hP+fQMLcIcOQzebCtwuiDjii64lnOb1SqHBMs+nHmIn3UkL33QIDAQABAoIBAQCEvvd9LUScUwLs0EXqsBxduMcYemeKUVrW3yR3gFjuczkcuEN/GbJrCMI6vpe9ToAM1hm+7dqtyOx52iBHpN85V7YHNOiF7Acy7OygFUfDuGT+X1stkNOC9qxsshpJ9yeW/L0hUqlh1SYZYNTjbcZMxoKAczY+UIQ2DU6rMVcCi290VceMB/XwyO5HDsoy0kExZf3s9oHjZ+8GQtDJt+R4mdJEG+eukOZ6uKf9lHYQR+8EafutMoGtATcfYiulLNjZsFigfh4/cGaOlZKX5Wgxtv+W5lE2hMLF597HEv2Ld1Mt0LwbWa93glRjArFo5vdq+TKBqkyboHdCyZwJijm9AoGBAOrHsJPDxlgiVy4XhXrrAwPCrM/Nlo6KFYqJcAq+g3npuAvDMrkxVbXAOFAVRRiQthTdh/WaTN9GOkau24k60MT0vPGswrWjGWWyWatLsVsg9Ncir1IjUy78rOoulMj+foLE0dETHdpQ1PzXxJGJMBMhJLJiut2S8neKidPT13cXAoGBAKJdA2WUK+uJxiL3HWKrAAo/5e9zyRO3cKX0ifJzU7pl5lhnfnGFFyFbyyN03vMWbRLrAzGQay0Wt+oP195q5K6CXh2h4HTTMgkO/NRLJ0YaiHRA6tEK/T/qowXArJp0opHs9kMuCYVdEdyPiGALxQHMrSkyOoWwvfPaqTByCCErAoGADcym6Eh9g/igvyjKw6rEhpgOqDghPUeIdJgXacpA2A2Qr8BNXu0zaHdf1/UoFoWK7jcHIrxrAESUcEsexDYcxzbLVDkfSKXJfFy7QII2bnDFc0+qll1VKlHXp/wM6rNqpC0FWBCTlJ1jp2jXOOajWLx9964t5ZAZiEUwTK8K3wkCgYAoTOQJ85RPO3xVs3a0xfMVmDSvkdLINREd8CvJZTzUGHTrXozxCnLqUcmDPIAWYGukdXbud4VSxL/TtikDyQ6IDk3kFwkKll1mCDVTUHAoI2/ZQz/FsW+YzNm4FNIC6I5toB6kICo20xoa3/metW0p/C7C+feytWMAwzaZksRXzwKBgQCCcDmAdOHaK5HuLSwqAxgFhXxd7z8/3yJwkjHDxVXgdI5EDZA9zuZqhmjQYlVjP2v1xOCNnTF/ybUkmupww5phcpCA/VSQYkNLwiOLbemjFBn00KQt997ngyqfoQBpsVbLKy3o1PJcZAM8OkXrNVADGMYlX+25WtbnqZjlMPNUTg==
6255f404-a761-4073-ab3b-5642de417ee5	5c3e9aa1-819e-45aa-8ef0-a9708edc3c6e	certificate	MIICmzCCAYMCBgF8h+J+vDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjExMDE2MDY1NDAwWhcNMzExMDE2MDY1NTQwWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCU56tmJ0/CDw+aN/vOenJKiZjniOxi6Ec6zDo8RO9Al1Lw0JG27W7EkU1fv3E+hfi7dTwL+BFDI4p+zwJKZbYkq4gPS9LqhN3L3gOAQYOpMNQIfAaqCSUZS9lDXKnwifozA1XBFjs72g3mqRBrWG8zafNMHO5RXMsTe7YXh5nWDIplIeI5lV9azZH55wB9IVznuRsVCGXu0s4aKTgtzKC2MfzfYoBjx8TrXT1Ulv48Ks6gWJI60os18tXHhJ4LBjgA9XLjmJZb8i+6nw9VHvTOCAh8EsrB/XMigvuE/59Awtwhw5DN5sK3C6IOOKLriWc5vVKocEyz6ceYifdSQvfdAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAE6nEPxtnJdFdz2hBOmRZXZkozfzFJOG6atGiydQ03nV0rD8LTVNAi0LT5y8ywwHsNgopULwhpXNNimWPACZtL9TUGJof2jOjTZPwlwZxRxloqldXUM4SPyy9h1/044Bzp7os+/VEqUVw9Tw4XbONuWeK3aDQMFcPKTLGO9fS0tnXXnc1PAwkqBwdAIeYIPpj7MfQ3WGcTb7zbZBV5lbYAA6z5IRW5tIg0uch7rXVtExxAz9VGvwQywyA2DdfOpiCC/4vSeqTSkKE2GuZMrANCSREVl4kpOeN0BS7dx9Yy62fs6M8xkfQwxUx8XQD/MAYHC3ClL+BZttkmNgw5+2aWs=
fb3b4330-c246-4bb7-b72c-7aa5ce6c3c6b	995bb5b5-7ef1-47ad-98a5-1cfb1735907f	privateKey	MIIEowIBAAKCAQEAjRoFU58UwIZS/fa3XZTL1L6AdjkZ0wBSO1TsA4aBf3rxORYS6O2Qa9NUKymnMJW2ljwTNLTM+5CjEz9+8lg5DeqQMfvix2OUefYh2Zx14/HsSAUV47lmioSMZeuSZbxUAjKdLEOh7SJ7IdTueRKfYg4wJepiNcPrgGpZJ9h0C0WFh+Q1nzi45sS3oxLuvGHE9v+4s0A+PgvLeIVC1kNUTP1lXDOsv8eim5y7VTNKuHdHjsKJMX4DveDwnNIWs4C8/tlQWC64jqN89dEn5K8s9QpamD6ep2UrFhnieuBsbQsZ9ATUdPayj0dDIrPEZsoNsRaPRzgvQpbIIX1ye64/SQIDAQABAoIBAGknIyEWRJjVgbPR0QTkhqKc9Y8lLqGYc6/Tsa9O5eLi9DHeyWjc4ev5KZihCf+jEtcTHh0BQGGZgG4vu6NPK/W7AIq/dFmzVEsvqjpJ53FgMP3bDF0RJeHEtfyeehNnLhQVNBxwqpPWRn0H+lAwGKcye59F9LqsryycFKUlIhXjL8w8I8wqrGrzeGFJ60Lp2dYyfrkydmu2YsczEGNQeHZY2CPdJL0XTlMXL/pGVYqvM9OCq4WUuSbY/04C07Qs9Vihb3cMzbY7nKppr3knuSojjfC/rz5M+LRFw/QT1y/Ex1OZxMRzGl//44hdFTPa57cDQslzyh6dVT+gttIQ36ECgYEA6zJ/BQN0zPHjl0Wof33r4ya28G+2lhOagczfNjFebndT0e7SHJSe7gurunu2DYZWk29niWnKLaFzcN13Y5ME36T/hNON5HqT/3qbV8fHWoSRXh6tuLWLb0hcsiN5SaReMtOUKsZuiScpzoQ+8rD4t3IxLav8qVZqFUfu3TOue8cCgYEAmZTx39gdXIRKUYb1izrT1CSsIyelax8C+GrU7rZq5TY6FZqkEMPQtlpSheUST67Pp7zybHf8o2/9FjUspgHT1O9jwOgSEGdfxr+RwwPVfDc1pER90Z4sIwkqdvJYhrDg8jynt/19+mz3p9FRUJgWNr57aFU2TgNzQFjgMUx8zG8CgYBJGYOy+jUGMbQL4yGQpoF3MyQurHnyQRuHdjZ18HgqGzpZCEITkfmngMcaCbM2luc3oatrYQ7uibyIerzNnPcpz21/SgVS2uo+wEuhx7zlHEjWGPDjdMFmj/YHg9EBm22PnITzmoLma96pih7KbUiQM5SnXkoEE5CbFqVd6N81JwKBgQCJBLYqE6BWWvwG8lX8ilZULQeaMZPGFxvKT117PyntJsz5W0bGYjzBg6GeLTmB957xsoPBu+acVZxBBN25mWXI0m53u1PqaJ+tLFo51yDOul7UF/r8WZZdB59oEVxjhkiaNP0ZDEIperAUe42FTrp6ysRE18kkHrXjEaeqs+efZwKBgBAImjwgMi+2x+4ojTS8lD90nTJlMwpJqQ+uCPuTgVA3Cyi7Qdw2MeBPAktfcTFhCO46slDak2tOV6qmCFZU+jqeFn2xNo3WYFcwDy+5f+QwL7CT5pXmBfnrhztoDNqpIktW1eLeaB8CcSHEMB6p2H8/sBNUq+SE7tI7yK+Jhmg/
9e2490d7-d524-4e85-967a-785750ad872e	995bb5b5-7ef1-47ad-98a5-1cfb1735907f	priority	100
545fa4c1-fc93-4002-9d7d-2796aacda26f	995bb5b5-7ef1-47ad-98a5-1cfb1735907f	keyUse	enc
3da41956-0734-4982-9efe-a2d353598bde	995bb5b5-7ef1-47ad-98a5-1cfb1735907f	certificate	MIICqzCCAZMCBgF8h+6jljANBgkqhkiG9w0BAQsFADAZMRcwFQYDVQQDDA5yZWFjdC1tYXJhdGhvbjAeFw0yMTEwMTYwNzA3MTZaFw0zMTEwMTYwNzA4NTZaMBkxFzAVBgNVBAMMDnJlYWN0LW1hcmF0aG9uMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjRoFU58UwIZS/fa3XZTL1L6AdjkZ0wBSO1TsA4aBf3rxORYS6O2Qa9NUKymnMJW2ljwTNLTM+5CjEz9+8lg5DeqQMfvix2OUefYh2Zx14/HsSAUV47lmioSMZeuSZbxUAjKdLEOh7SJ7IdTueRKfYg4wJepiNcPrgGpZJ9h0C0WFh+Q1nzi45sS3oxLuvGHE9v+4s0A+PgvLeIVC1kNUTP1lXDOsv8eim5y7VTNKuHdHjsKJMX4DveDwnNIWs4C8/tlQWC64jqN89dEn5K8s9QpamD6ep2UrFhnieuBsbQsZ9ATUdPayj0dDIrPEZsoNsRaPRzgvQpbIIX1ye64/SQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQBECs9AJvWeKGrNukjoXTQwuCxv39gfv35e6lVxsUqd0Hm9OpDhJS+j9u58rUkc/IV0ldW9wEtajX8SrG+T91tYTJR36Q8HilK1hip8MXz6odfCkanH3B7dLVKfeloHpBh0hCQt57T3gjuZfLGEybKzB4PmJFSDbyupeLVUpPtW+fZZYK4oWsjhpYGxWkO2T4A0GT2tiha9nfK0D+eLRpJPuiDo85RyJ1/cdUCNjxsaGINTElfzzFlD8cNzobaUiY4/q1a58pNfskwrUnlmefmXLAA3sdBBr5idtmYL2uZSXuZNlUq908SVVE3T9oAGhnKlemQPgMR13lqY0u5C4V2C
8bd60104-793a-47d3-a15b-2969c4d90319	901c7921-9331-4710-a120-08d787182770	priority	100
4c072baf-a484-41bf-a47c-dfa6b2b1ad6d	901c7921-9331-4710-a120-08d787182770	keyUse	sig
b3ad1324-8902-4efc-924e-da6259507d14	901c7921-9331-4710-a120-08d787182770	certificate	MIICqzCCAZMCBgF8h+6jLTANBgkqhkiG9w0BAQsFADAZMRcwFQYDVQQDDA5yZWFjdC1tYXJhdGhvbjAeFw0yMTEwMTYwNzA3MTZaFw0zMTEwMTYwNzA4NTZaMBkxFzAVBgNVBAMMDnJlYWN0LW1hcmF0aG9uMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAg4wiDi+tI9LRn5WvyZbQJqRUzWolhS9i77okjl5dlQEIfM7toUCHF54mPrn5U4PETS4GjHleSae8OZvgJiMyqECtF5UNLMeLWGYPk7p2pt21VjlrCjKu6/elEAhV46LsHaJ5A5ECC6HOQd2vB9xgjMkeEMsQ9/NaQaLAqUIOVyJIqejae66Ry3WtPNZ6+aj5Q5HTpp5GYGL9P+WfJKprixgquwh9D0eo/jCe9wBliSmQDJqdf4gBPQ3AFnTS3cxcsaldzW3DeDag1n8ucnIlhdyjEwwX2D1s6lVdlIT2ORhVgsK4NC03qxKbpEkXz8X0RYXdCbEuY0y923KdERnBCQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQAmX8jb0i8ahDnwPye76bEAIuCx9VEuP5FYPU5jA30QcH5GB4MAIquD+cFNsd2bdhgal3WNwu00sJWH5gYBficQxQQ/USF0fWoGMqgnmgecqn60C9fZNTVcAA3sD3VTaK0v6NK/ptPdbk1GyGkiy6qq+b1DNzCsDqcRwQcN2yTlMQaDD6xGcIFxqh/GAvpFGli4PSRyKlnxO8Kx2jnm1uDVsdvp9HxVVKQJY4r6H26WLmbRn3jrDvICEOUnq86WppjuILNBLMQdiMowZfr5sVxJd7HgV0+3u4IEKGzJ+1ImGqVaOxPYJNeIO73St4t1X33BraXjNpQOVxCl8JaZavs/
14f28f0f-fa76-498d-891a-b6b35893e9f5	901c7921-9331-4710-a120-08d787182770	privateKey	MIIEogIBAAKCAQEAg4wiDi+tI9LRn5WvyZbQJqRUzWolhS9i77okjl5dlQEIfM7toUCHF54mPrn5U4PETS4GjHleSae8OZvgJiMyqECtF5UNLMeLWGYPk7p2pt21VjlrCjKu6/elEAhV46LsHaJ5A5ECC6HOQd2vB9xgjMkeEMsQ9/NaQaLAqUIOVyJIqejae66Ry3WtPNZ6+aj5Q5HTpp5GYGL9P+WfJKprixgquwh9D0eo/jCe9wBliSmQDJqdf4gBPQ3AFnTS3cxcsaldzW3DeDag1n8ucnIlhdyjEwwX2D1s6lVdlIT2ORhVgsK4NC03qxKbpEkXz8X0RYXdCbEuY0y923KdERnBCQIDAQABAoIBAAU7F0eVIb9g7LD51MmhU5mVw0F/zQokvjxmHHoEypfYOKwt1kkpNbX8teycnItzm+StxdjkIpmvL87ioeEiWStTlw5vAN0c+i+Dr27iZUFxY3qQQe9f4JDFgizHCBNLMTRkd4dqxrgLsRXxaLpZSwWOIcHtMTmK1bXycNLKK6PPTF1eKcY+8p8fqC//6q+teC7Ooc7uqlmIvr7I22ceirU22Psif3Z8TGmtqEMivHqZs7omocVn8oKAjeQyEqR8O+BvrZJy1V3L77Y27i5WGmL0rnosB8vdmFngiFdC/XsXQXs+zYBzlYr9OsK97wE780F/s2/7uv6wLm+6QPxzi5kCgYEA2xstP9CjQIyd+iSjsTzK2qqq/wKq/35K4XUr+Vv0joLPwyJ6uzimZV64vgQJ2d6yFVftHDOVHbLc9nc17QJuooWzyr4j64PFTbM2Hms4XY2MUQCVN0TZk7/MK6BZywiDtkQSiLExe+P/eo15OgRYXrimtpWF1C7dxSlcoZDcib8CgYEAmbKiilIrQbek4bEKpA4w2NLHuls1wRFV+BSjCQDn+utyCX0ZY2+0CXhdKieE09XeZbKtg0H03J6E1oPwnuBjY6jC4mvJLJJGvTd1bQfJhqNVfAhlAGn+pSdOO5nbuNYh09l6edm3XNOSqaNqg03KRQ1E1FxIIyb1Pwpt7kSoFzcCgYAy7XkyCQu5GDYsC1IlAy1fcCX4yiT25+L9zp9fAXmxmkQyZhRC6iL7Eu479HJZusKH5X0Ofgrd8VIc046sPVF74znsGQ/+UQ2ORuaAYYmjbSA9P7ZvN0ifaAhL56SXZa4/skjgjtcipdcfJD0WOCZWNfNCIzUNIauYhUmroCEyvwKBgF7k4uQB7YEqsFtEIqy9sjz8jqIplFu6p1h+7VYuwAu0+HiRS26QVhkOvn67XZAo2KHzmpuSymq4WI3Vcme1ZMfwNzryj4e8XH6Q0ihaCXveNnZY/Hsv9i/jv7KewQEy/Dm/aZX37PUcD846/hVJnxvZIGj4/PTvJbYha1QUAbArAoGAfHip03YvzOe/x1RigJSzG4gousX1fzJkDjW2tW6KrDfj3CGdbi2gi3Fh77mIGftIfAOKiejxs/AVmG9PHhd2tfhnsvLmOWk9qlHS/mczauJhwQj0HdrVo3UoDI1aHe80LT1pvp4PbkcGW82a18oR0Ubf1qvOGXI+aQVX5mSwROI=
19bcd2d8-8ead-466f-8afc-2945feec68a4	ee79bb03-f070-4ff2-ae7d-fd92ef125d19	kid	eb893f7f-c4a5-425e-8e34-76b28c04e5bd
0b5294be-f2c6-4724-a865-e51e00d27e4e	ee79bb03-f070-4ff2-ae7d-fd92ef125d19	priority	100
50762d92-f203-4b09-8fcb-a577dc2fdfe4	ee79bb03-f070-4ff2-ae7d-fd92ef125d19	secret	oLaETtipu0e8K9wDQcogAw
f2c7f849-a51f-49cf-9f6e-9a40f3d8624c	0ece05ec-19e8-4cd3-8ed6-27a1bc6e26eb	kid	5d30e675-1831-4163-9c98-aea97c664a16
ef6f1ec4-88c9-4151-b5a1-299eb5d66e79	0ece05ec-19e8-4cd3-8ed6-27a1bc6e26eb	priority	100
2b556cc0-daec-4241-ab46-913d7937085a	0ece05ec-19e8-4cd3-8ed6-27a1bc6e26eb	algorithm	HS256
a540ec12-f084-4714-937c-00b96baac577	0ece05ec-19e8-4cd3-8ed6-27a1bc6e26eb	secret	IalLl2wLl8LQV7d4HZPLzY61fupnsOp9JDJ3z7UnoobNnCf7INaCwfNN59ggEo6F0f-KljMPd_Z_YxSZFdyoHQ
0cb393a5-5a13-4d57-9960-99d78f11e779	b2d8e390-435c-4d23-a66d-1ef944ee85e3	host-sending-registration-request-must-match	true
5dd3a7fc-d52d-47f3-94cf-5f951dc2dfef	b2d8e390-435c-4d23-a66d-1ef944ee85e3	client-uris-must-match	true
78459db5-cf89-419e-ada8-0d162cceff75	b6f78a3b-baf3-40a0-8456-50951c159714	allow-default-scopes	true
c8db637c-5fdd-42d3-a28f-16f810aa0ee2	1b6c4a23-09b5-4224-a631-401227a3e213	allow-default-scopes	true
e6ba0d22-5e68-4091-bb24-0cc157c79951	3495aae0-0524-49d5-8ede-f5435316267b	max-clients	200
d3764378-d84d-418f-9755-3d3b7d27ec46	b853eeee-82fd-4b9d-9671-f2fa3e265dfd	allowed-protocol-mapper-types	oidc-full-name-mapper
ee041e00-74f2-4ff0-abfd-5ea7484819e3	b853eeee-82fd-4b9d-9671-f2fa3e265dfd	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
f5ab5498-91e7-48df-9926-66707edeaf58	b853eeee-82fd-4b9d-9671-f2fa3e265dfd	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
a5f6d61e-bbf8-4e19-9e98-76b29b62ad8b	b853eeee-82fd-4b9d-9671-f2fa3e265dfd	allowed-protocol-mapper-types	saml-user-property-mapper
6add0880-98a8-4d6a-8b4d-77a5a0accf9b	b853eeee-82fd-4b9d-9671-f2fa3e265dfd	allowed-protocol-mapper-types	oidc-address-mapper
28a18b9a-d350-47fa-bde8-ce3264e0242e	b853eeee-82fd-4b9d-9671-f2fa3e265dfd	allowed-protocol-mapper-types	saml-user-attribute-mapper
a7029ba9-dee7-4438-af80-ff9455ff062a	b853eeee-82fd-4b9d-9671-f2fa3e265dfd	allowed-protocol-mapper-types	saml-role-list-mapper
adf73187-7c96-4a57-8d96-fb2e4c62d669	b853eeee-82fd-4b9d-9671-f2fa3e265dfd	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
f3ca51a5-b15a-41cd-b375-9edd19d89a08	c28b5f2d-9807-46d5-9bfc-bc40017eb1fa	allowed-protocol-mapper-types	saml-role-list-mapper
c3e7c04d-08be-4765-89ac-b8465159a172	c28b5f2d-9807-46d5-9bfc-bc40017eb1fa	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
1e5939fb-0cac-4dfb-8825-8ae725dd5c61	c28b5f2d-9807-46d5-9bfc-bc40017eb1fa	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
0e9fa364-75b4-4d98-8180-de37b1a2d5f4	c28b5f2d-9807-46d5-9bfc-bc40017eb1fa	allowed-protocol-mapper-types	saml-user-property-mapper
8ad54673-c0a9-40b8-8c74-2e0136391e2a	c28b5f2d-9807-46d5-9bfc-bc40017eb1fa	allowed-protocol-mapper-types	saml-user-attribute-mapper
d537885c-255d-48c1-a41a-925d3a5be01e	c28b5f2d-9807-46d5-9bfc-bc40017eb1fa	allowed-protocol-mapper-types	oidc-full-name-mapper
970599cc-4403-41d9-a4a5-680f1760418d	c28b5f2d-9807-46d5-9bfc-bc40017eb1fa	allowed-protocol-mapper-types	oidc-address-mapper
366c175f-86bf-49c8-87dd-ebf375d8247a	c28b5f2d-9807-46d5-9bfc-bc40017eb1fa	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.composite_role (composite, child_role) FROM stdin;
7ab49848-9cb9-4c00-b817-75b2f4e143e3	8aec0440-b89c-409f-b35a-799962660dd9
7ab49848-9cb9-4c00-b817-75b2f4e143e3	37383584-6613-4e94-9f4b-c2813c66362e
7ab49848-9cb9-4c00-b817-75b2f4e143e3	bfba0c41-1d0a-4384-a98c-e04e0160f512
7ab49848-9cb9-4c00-b817-75b2f4e143e3	a459dd2e-8150-4673-819a-54921d371d5f
7ab49848-9cb9-4c00-b817-75b2f4e143e3	143055b1-ef3f-4470-8fd9-2719e26f9179
7ab49848-9cb9-4c00-b817-75b2f4e143e3	6ba5ec2c-f525-448f-9478-7efffec9bfd6
7ab49848-9cb9-4c00-b817-75b2f4e143e3	fa20a8d0-a645-4a80-a00c-af887810029f
7ab49848-9cb9-4c00-b817-75b2f4e143e3	6674e620-5761-4918-90e8-10111b882d10
7ab49848-9cb9-4c00-b817-75b2f4e143e3	2c7f8fe2-84cd-4955-acf8-2444fbc44eae
7ab49848-9cb9-4c00-b817-75b2f4e143e3	f88188f3-4dcb-48a4-bb3a-2ba34ec1cec5
7ab49848-9cb9-4c00-b817-75b2f4e143e3	432b9a79-bd29-4c7f-91a4-465e70f6b7a4
7ab49848-9cb9-4c00-b817-75b2f4e143e3	41f8514c-6cfc-42c4-8c45-6d379b45fd09
7ab49848-9cb9-4c00-b817-75b2f4e143e3	8e2a6b77-7ad2-4fb9-8427-4ba77f3fe036
7ab49848-9cb9-4c00-b817-75b2f4e143e3	a3242760-e863-45a7-8e24-fbb33c39fc5a
7ab49848-9cb9-4c00-b817-75b2f4e143e3	2302679b-3499-4387-a19a-6b5772c48d4e
7ab49848-9cb9-4c00-b817-75b2f4e143e3	1dc53b69-08fa-419b-bab9-d8d0db8e2bef
7ab49848-9cb9-4c00-b817-75b2f4e143e3	3dd6d00e-ecfa-44b0-b463-e6308e2a5eec
7ab49848-9cb9-4c00-b817-75b2f4e143e3	a6714763-9454-41a2-b385-74bfb9cc5817
143055b1-ef3f-4470-8fd9-2719e26f9179	1dc53b69-08fa-419b-bab9-d8d0db8e2bef
a459dd2e-8150-4673-819a-54921d371d5f	a6714763-9454-41a2-b385-74bfb9cc5817
a459dd2e-8150-4673-819a-54921d371d5f	2302679b-3499-4387-a19a-6b5772c48d4e
c63f674f-7046-468b-80cb-2ce724540674	cf7ef87b-e49a-4547-838f-0fd9bdb765ab
c63f674f-7046-468b-80cb-2ce724540674	a7a0cf19-fff5-4693-93fb-7c7d6ca37f30
a7a0cf19-fff5-4693-93fb-7c7d6ca37f30	a2dde0e3-98b7-4760-93da-09cb0a1b4b3c
d9497595-06ca-47b4-a4b1-bf99189fdc02	3d1f04a2-a373-479c-bd9d-cb19a338ea0f
7ab49848-9cb9-4c00-b817-75b2f4e143e3	425536d0-bac9-4748-a437-7c89b8eba599
c63f674f-7046-468b-80cb-2ce724540674	1ed40bcd-384c-4228-9af8-59f3cd67d87c
c63f674f-7046-468b-80cb-2ce724540674	5e48e552-8816-4904-a586-71a938d486ce
7ab49848-9cb9-4c00-b817-75b2f4e143e3	87654c08-d465-4617-80bf-8ef268aeac0a
7ab49848-9cb9-4c00-b817-75b2f4e143e3	41af9949-9649-4f20-8354-e3ec46bf44e4
7ab49848-9cb9-4c00-b817-75b2f4e143e3	2c3b8020-3978-4b15-a045-1afbe0fa91cb
7ab49848-9cb9-4c00-b817-75b2f4e143e3	17eb16f1-b4c7-4ea6-b50f-1e2d583009c5
7ab49848-9cb9-4c00-b817-75b2f4e143e3	843453a0-55aa-4bc1-b4e8-0c2cfd79f683
7ab49848-9cb9-4c00-b817-75b2f4e143e3	8b86192f-211f-4c7c-a013-7e75b155f861
7ab49848-9cb9-4c00-b817-75b2f4e143e3	056fbcf6-2912-47b7-b0eb-7b30ea0ec045
7ab49848-9cb9-4c00-b817-75b2f4e143e3	f360b96d-65cc-4d2d-9fff-e095032703d1
7ab49848-9cb9-4c00-b817-75b2f4e143e3	c6862cd8-5cda-4d69-837e-0be7086f6365
7ab49848-9cb9-4c00-b817-75b2f4e143e3	9ae8a7c9-449f-4792-8520-32f7a6d4e616
7ab49848-9cb9-4c00-b817-75b2f4e143e3	ea9f5642-1174-4f3a-a0bf-f1e199e5b5a3
7ab49848-9cb9-4c00-b817-75b2f4e143e3	35f9246a-fef9-404d-97a8-dafd6fc37875
7ab49848-9cb9-4c00-b817-75b2f4e143e3	dd25c379-a83b-4bb7-a8c6-5ba81f4e0d34
7ab49848-9cb9-4c00-b817-75b2f4e143e3	dc29cf4a-b081-4ad9-af1f-a913d10c15a7
7ab49848-9cb9-4c00-b817-75b2f4e143e3	5d964daf-6ef2-4f44-853e-5fc12aaca564
7ab49848-9cb9-4c00-b817-75b2f4e143e3	51272787-e3af-44eb-830d-cb6726f02728
7ab49848-9cb9-4c00-b817-75b2f4e143e3	eb87a519-9433-47a4-99cc-2fd04558315d
17eb16f1-b4c7-4ea6-b50f-1e2d583009c5	5d964daf-6ef2-4f44-853e-5fc12aaca564
2c3b8020-3978-4b15-a045-1afbe0fa91cb	eb87a519-9433-47a4-99cc-2fd04558315d
2c3b8020-3978-4b15-a045-1afbe0fa91cb	dc29cf4a-b081-4ad9-af1f-a913d10c15a7
40636fd6-976e-4b8a-984c-44edc3ed6234	7dd70717-55ea-47d7-b218-a912c571064f
40636fd6-976e-4b8a-984c-44edc3ed6234	730844ae-ee13-4c8c-bb6a-aec5146f97cb
40636fd6-976e-4b8a-984c-44edc3ed6234	b015fd6f-2f3a-439d-82cb-e1e390af05e0
40636fd6-976e-4b8a-984c-44edc3ed6234	3e4c2423-4376-4ac4-9f86-63cfef26a56b
40636fd6-976e-4b8a-984c-44edc3ed6234	a803c277-c72d-43da-9b59-9644cde63cc6
40636fd6-976e-4b8a-984c-44edc3ed6234	be50ca12-a9c7-46b4-823c-dc23739032c2
40636fd6-976e-4b8a-984c-44edc3ed6234	8ccd7ff6-3133-49e9-b50e-2a7c05b9d538
40636fd6-976e-4b8a-984c-44edc3ed6234	58f21d5c-994a-4c1f-af03-bc7f06f2e889
40636fd6-976e-4b8a-984c-44edc3ed6234	656131d5-19d4-45ee-a58e-6e607a6ae549
40636fd6-976e-4b8a-984c-44edc3ed6234	46f9b6fd-5d6b-449c-b57e-8522c65d7a6f
40636fd6-976e-4b8a-984c-44edc3ed6234	8353c43b-8504-4c0b-ad5e-4ce769bed0be
40636fd6-976e-4b8a-984c-44edc3ed6234	051f1e08-e137-4dff-aff7-e1be9eba7a55
40636fd6-976e-4b8a-984c-44edc3ed6234	09e51aad-9056-4b9c-a522-220ec5ee7f06
40636fd6-976e-4b8a-984c-44edc3ed6234	3df43416-8374-403d-81b1-7baa4d5d5661
40636fd6-976e-4b8a-984c-44edc3ed6234	18d4ddfd-0810-4b07-8062-470a513b94ee
40636fd6-976e-4b8a-984c-44edc3ed6234	905c7581-47b0-498c-8360-311c0990802d
40636fd6-976e-4b8a-984c-44edc3ed6234	3480dcb4-1113-4f34-b5ce-b192f033666d
3e4c2423-4376-4ac4-9f86-63cfef26a56b	18d4ddfd-0810-4b07-8062-470a513b94ee
b015fd6f-2f3a-439d-82cb-e1e390af05e0	3480dcb4-1113-4f34-b5ce-b192f033666d
b015fd6f-2f3a-439d-82cb-e1e390af05e0	3df43416-8374-403d-81b1-7baa4d5d5661
08c3b01c-f2b9-400a-932b-8aa54d076168	49b9e494-a292-4733-a4d1-efbae6af86e9
08c3b01c-f2b9-400a-932b-8aa54d076168	f8cd713c-e194-4ba4-b08f-1ca0b0e9a612
f8cd713c-e194-4ba4-b08f-1ca0b0e9a612	1e851f6a-380c-48ed-a3ae-a7536f8cbd22
0c1d9677-bfa6-4e85-bb89-cf0f4e08943e	96fb14e2-453b-4e5b-aea2-c9806684ebcd
7ab49848-9cb9-4c00-b817-75b2f4e143e3	f836f04a-a3b8-409c-bd43-57b76e26a622
40636fd6-976e-4b8a-984c-44edc3ed6234	ec719926-474e-4ac8-8fff-4d68ebce32ab
08c3b01c-f2b9-400a-932b-8aa54d076168	8b25c2be-145c-4015-96d1-639ea689d2aa
08c3b01c-f2b9-400a-932b-8aa54d076168	755b6afc-7112-4bd6-9ef1-8b0ab3c3de65
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
3b3d10a1-5b6a-403f-b4d7-a427e8bc180a	\N	password	ff4a6f5a-25b1-45f0-9682-7b24284ea644	1634367340793	\N	{"value":"jFq+j5+1DLVObZJJUG7z+84QuTIJamPgqDoE4TSYyQzFKJhRDHaiAI4aMFF9jdYn9v3kzzULgLVKUZFUPEZ3aQ==","salt":"WscfcNgW2vghjYKx2N2ABQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
d36f8cf3-6725-472a-8c6c-85a88ccf6607	\N	password	fda8950c-ee46-4236-81f8-8b93908aa302	1634368312152	\N	{"value":"ZvjQZCeu7aC8Outd1StThlixvpldL8TMXVNfXE7eknXR7mnrDM5+VD4yE+CvabspqzyqVei3wdu9t/qm2DgVjg==","salt":"EPGAyctWwsMl7YWuKSytaA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
28229034-28ed-42ed-8cb2-1a0ac4b86864	\N	password	21ce4760-0f9d-4885-8b24-5b013838c11d	1634478187625	\N	{"value":"+7wgYGIcpc0Xc/NE3u4AZay/OAqdNTks1hj7xDXRQCljlCvMDI2KUk3lQjIdxNRMmb6JMCHBtd6hWcuk+6fNng==","salt":"sq7nWKWLPCfyR72R1AgoPg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
aee8fe58-a40d-4d91-99f9-f98161fe2586	\N	password	ec357381-e333-4868-9941-1f01b3c5d596	1634478206959	\N	{"value":"dGGdt0U8LSLvJKkwXa7p4HuAQWI9ovRzLJakuBKB/1xyruXTYv8GaTGVL4vHMMsvewaT+X8vRwPTnfVwBbEpNA==","salt":"Y7Nk/z+Jcmduvj1nrH7WVA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
02a08535-fc6f-4680-bef7-3f0347a04727	\N	password	d5c06209-b65e-4d2c-8859-d4e66795505d	1634478223397	\N	{"value":"fapc6e7/4jatwVR+BZq+BS4Z6qHrncbX2N54jUsEl6QNXaaEG8eb9so8c+3C7ms6LaaUXU/mP/HIXF2k8QavdQ==","salt":"/Wp3WY9zLrKYICZpenRFtQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2021-10-16 06:55:32.581776	1	EXECUTED	7:4e70412f24a3f382c82183742ec79317	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	4367332047
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2021-10-16 06:55:32.596469	2	MARK_RAN	7:cb16724583e9675711801c6875114f28	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	4367332047
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2021-10-16 06:55:32.74306	3	EXECUTED	7:0310eb8ba07cec616460794d42ade0fa	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	3.5.4	\N	\N	4367332047
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2021-10-16 06:55:32.751876	4	EXECUTED	7:5d25857e708c3233ef4439df1f93f012	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	4367332047
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2021-10-16 06:55:32.920014	5	EXECUTED	7:c7a54a1041d58eb3817a4a883b4d4e84	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	4367332047
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2021-10-16 06:55:32.928543	6	MARK_RAN	7:2e01012df20974c1c2a605ef8afe25b7	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	4367332047
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2021-10-16 06:55:33.069187	7	EXECUTED	7:0f08df48468428e0f30ee59a8ec01a41	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	4367332047
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2021-10-16 06:55:33.075342	8	MARK_RAN	7:a77ea2ad226b345e7d689d366f185c8c	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	4367332047
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2021-10-16 06:55:33.082412	9	EXECUTED	7:a3377a2059aefbf3b90ebb4c4cc8e2ab	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	3.5.4	\N	\N	4367332047
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2021-10-16 06:55:33.253903	10	EXECUTED	7:04c1dbedc2aa3e9756d1a1668e003451	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	3.5.4	\N	\N	4367332047
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2021-10-16 06:55:33.351329	11	EXECUTED	7:36ef39ed560ad07062d956db861042ba	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	4367332047
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2021-10-16 06:55:33.35667	12	MARK_RAN	7:d909180b2530479a716d3f9c9eaea3d7	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	4367332047
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2021-10-16 06:55:33.37772	13	EXECUTED	7:cf12b04b79bea5152f165eb41f3955f6	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	4367332047
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-10-16 06:55:33.433288	14	EXECUTED	7:7e32c8f05c755e8675764e7d5f514509	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	3.5.4	\N	\N	4367332047
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-10-16 06:55:33.438475	15	MARK_RAN	7:980ba23cc0ec39cab731ce903dd01291	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	4367332047
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-10-16 06:55:33.443004	16	MARK_RAN	7:2fa220758991285312eb84f3b4ff5336	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	3.5.4	\N	\N	4367332047
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-10-16 06:55:33.447324	17	EXECUTED	7:d41d8cd98f00b204e9800998ecf8427e	empty		\N	3.5.4	\N	\N	4367332047
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2021-10-16 06:55:33.521361	18	EXECUTED	7:91ace540896df890cc00a0490ee52bbc	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	3.5.4	\N	\N	4367332047
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2021-10-16 06:55:33.594631	19	EXECUTED	7:c31d1646dfa2618a9335c00e07f89f24	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	4367332047
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2021-10-16 06:55:33.603606	20	EXECUTED	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	4367332047
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-10-16 06:55:35.268918	45	EXECUTED	7:6a48ce645a3525488a90fbf76adf3bb3	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	4367332047
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2021-10-16 06:55:33.608174	21	MARK_RAN	7:f987971fe6b37d963bc95fee2b27f8df	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	4367332047
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2021-10-16 06:55:33.61269	22	MARK_RAN	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	4367332047
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2021-10-16 06:55:33.657345	23	EXECUTED	7:ed2dc7f799d19ac452cbcda56c929e47	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	3.5.4	\N	\N	4367332047
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2021-10-16 06:55:33.66728	24	EXECUTED	7:80b5db88a5dda36ece5f235be8757615	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	4367332047
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2021-10-16 06:55:33.671809	25	MARK_RAN	7:1437310ed1305a9b93f8848f301726ce	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	4367332047
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2021-10-16 06:55:33.910165	26	EXECUTED	7:b82ffb34850fa0836be16deefc6a87c4	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	3.5.4	\N	\N	4367332047
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2021-10-16 06:55:34.059746	27	EXECUTED	7:9cc98082921330d8d9266decdd4bd658	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	3.5.4	\N	\N	4367332047
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2021-10-16 06:55:34.066008	28	EXECUTED	7:03d64aeed9cb52b969bd30a7ac0db57e	update tableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	4367332047
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2021-10-16 06:55:34.22685	29	EXECUTED	7:f1f9fd8710399d725b780f463c6b21cd	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	3.5.4	\N	\N	4367332047
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2021-10-16 06:55:34.255273	30	EXECUTED	7:53188c3eb1107546e6f765835705b6c1	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	3.5.4	\N	\N	4367332047
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2021-10-16 06:55:34.288819	31	EXECUTED	7:d6e6f3bc57a0c5586737d1351725d4d4	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	3.5.4	\N	\N	4367332047
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2021-10-16 06:55:34.295662	32	EXECUTED	7:454d604fbd755d9df3fd9c6329043aa5	customChange		\N	3.5.4	\N	\N	4367332047
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-10-16 06:55:34.305461	33	EXECUTED	7:57e98a3077e29caf562f7dbf80c72600	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	4367332047
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-10-16 06:55:34.310019	34	MARK_RAN	7:e4c7e8f2256210aee71ddc42f538b57a	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	4367332047
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-10-16 06:55:34.357214	35	EXECUTED	7:09a43c97e49bc626460480aa1379b522	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	4367332047
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2021-10-16 06:55:34.366835	36	EXECUTED	7:26bfc7c74fefa9126f2ce702fb775553	addColumn tableName=REALM		\N	3.5.4	\N	\N	4367332047
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-10-16 06:55:34.383876	37	EXECUTED	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	4367332047
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2021-10-16 06:55:34.392085	38	EXECUTED	7:37fc1781855ac5388c494f1442b3f717	addColumn tableName=FED_USER_CONSENT		\N	3.5.4	\N	\N	4367332047
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2021-10-16 06:55:34.401204	39	EXECUTED	7:13a27db0dae6049541136adad7261d27	addColumn tableName=IDENTITY_PROVIDER		\N	3.5.4	\N	\N	4367332047
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-10-16 06:55:34.406472	40	MARK_RAN	7:550300617e3b59e8af3a6294df8248a3	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	4367332047
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-10-16 06:55:34.410743	41	MARK_RAN	7:e3a9482b8931481dc2772a5c07c44f17	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	4367332047
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2021-10-16 06:55:34.417339	42	EXECUTED	7:72b07d85a2677cb257edb02b408f332d	customChange		\N	3.5.4	\N	\N	4367332047
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-10-16 06:55:35.250258	43	EXECUTED	7:a72a7858967bd414835d19e04d880312	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	3.5.4	\N	\N	4367332047
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2021-10-16 06:55:35.260324	44	EXECUTED	7:94edff7cf9ce179e7e85f0cd78a3cf2c	addColumn tableName=USER_ENTITY		\N	3.5.4	\N	\N	4367332047
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-10-16 06:55:35.275973	46	EXECUTED	7:e64b5dcea7db06077c6e57d3b9e5ca14	customChange		\N	3.5.4	\N	\N	4367332047
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-10-16 06:55:35.280683	47	MARK_RAN	7:fd8cf02498f8b1e72496a20afc75178c	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	4367332047
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-10-16 06:55:35.379458	48	EXECUTED	7:542794f25aa2b1fbabb7e577d6646319	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	3.5.4	\N	\N	4367332047
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-10-16 06:55:35.396862	49	EXECUTED	7:edad604c882df12f74941dac3cc6d650	addColumn tableName=REALM		\N	3.5.4	\N	\N	4367332047
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2021-10-16 06:55:35.513327	50	EXECUTED	7:0f88b78b7b46480eb92690cbf5e44900	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	3.5.4	\N	\N	4367332047
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2021-10-16 06:55:35.698005	51	EXECUTED	7:d560e43982611d936457c327f872dd59	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	3.5.4	\N	\N	4367332047
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2021-10-16 06:55:35.706655	52	EXECUTED	7:c155566c42b4d14ef07059ec3b3bbd8e	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	4367332047
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2021-10-16 06:55:35.711817	53	EXECUTED	7:b40376581f12d70f3c89ba8ddf5b7dea	update tableName=REALM		\N	3.5.4	\N	\N	4367332047
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2021-10-16 06:55:35.716823	54	EXECUTED	7:a1132cc395f7b95b3646146c2e38f168	update tableName=CLIENT		\N	3.5.4	\N	\N	4367332047
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-10-16 06:55:35.732417	55	EXECUTED	7:d8dc5d89c789105cfa7ca0e82cba60af	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	3.5.4	\N	\N	4367332047
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-10-16 06:55:35.741871	56	EXECUTED	7:7822e0165097182e8f653c35517656a3	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	3.5.4	\N	\N	4367332047
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-10-16 06:55:35.796653	57	EXECUTED	7:c6538c29b9c9a08f9e9ea2de5c2b6375	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	3.5.4	\N	\N	4367332047
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-10-16 06:55:36.039946	58	EXECUTED	7:6d4893e36de22369cf73bcb051ded875	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	3.5.4	\N	\N	4367332047
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2021-10-16 06:55:36.089809	59	EXECUTED	7:57960fc0b0f0dd0563ea6f8b2e4a1707	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	3.5.4	\N	\N	4367332047
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2021-10-16 06:55:36.09985	60	EXECUTED	7:2b4b8bff39944c7097977cc18dbceb3b	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	4367332047
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2021-10-16 06:55:36.111537	61	EXECUTED	7:2aa42a964c59cd5b8ca9822340ba33a8	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	3.5.4	\N	\N	4367332047
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2021-10-16 06:55:36.126934	62	EXECUTED	7:9ac9e58545479929ba23f4a3087a0346	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	3.5.4	\N	\N	4367332047
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2021-10-16 06:55:36.136592	63	EXECUTED	7:14d407c35bc4fe1976867756bcea0c36	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	4367332047
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2021-10-16 06:55:36.141807	64	EXECUTED	7:241a8030c748c8548e346adee548fa93	update tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	4367332047
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2021-10-16 06:55:36.147151	65	EXECUTED	7:7d3182f65a34fcc61e8d23def037dc3f	update tableName=RESOURCE_SERVER_RESOURCE		\N	3.5.4	\N	\N	4367332047
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2021-10-16 06:55:36.188234	66	EXECUTED	7:b30039e00a0b9715d430d1b0636728fa	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	3.5.4	\N	\N	4367332047
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2021-10-16 06:55:36.216886	67	EXECUTED	7:3797315ca61d531780f8e6f82f258159	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	3.5.4	\N	\N	4367332047
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2021-10-16 06:55:36.225526	68	EXECUTED	7:c7aa4c8d9573500c2d347c1941ff0301	addColumn tableName=REALM		\N	3.5.4	\N	\N	4367332047
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2021-10-16 06:55:36.251471	69	EXECUTED	7:b207faee394fc074a442ecd42185a5dd	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	3.5.4	\N	\N	4367332047
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2021-10-16 06:55:36.260909	70	EXECUTED	7:ab9a9762faaba4ddfa35514b212c4922	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	3.5.4	\N	\N	4367332047
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2021-10-16 06:55:36.269097	71	EXECUTED	7:b9710f74515a6ccb51b72dc0d19df8c4	addColumn tableName=RESOURCE_SERVER		\N	3.5.4	\N	\N	4367332047
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-10-16 06:55:36.279339	72	EXECUTED	7:ec9707ae4d4f0b7452fee20128083879	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	4367332047
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-10-16 06:55:36.286887	73	EXECUTED	7:3979a0ae07ac465e920ca696532fc736	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	4367332047
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-10-16 06:55:36.291339	74	MARK_RAN	7:5abfde4c259119d143bd2fbf49ac2bca	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	4367332047
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-10-16 06:55:36.308269	75	EXECUTED	7:b48da8c11a3d83ddd6b7d0c8c2219345	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	3.5.4	\N	\N	4367332047
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-10-16 06:55:36.338693	76	EXECUTED	7:a73379915c23bfad3e8f5c6d5c0aa4bd	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	3.5.4	\N	\N	4367332047
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-10-16 06:55:36.346615	77	EXECUTED	7:39e0073779aba192646291aa2332493d	addColumn tableName=CLIENT		\N	3.5.4	\N	\N	4367332047
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-10-16 06:55:36.351111	78	MARK_RAN	7:81f87368f00450799b4bf42ea0b3ec34	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	3.5.4	\N	\N	4367332047
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-10-16 06:55:36.379626	79	EXECUTED	7:20b37422abb9fb6571c618148f013a15	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	3.5.4	\N	\N	4367332047
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-10-16 06:55:36.383978	80	MARK_RAN	7:1970bb6cfb5ee800736b95ad3fb3c78a	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	3.5.4	\N	\N	4367332047
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-10-16 06:55:36.412132	81	EXECUTED	7:45d9b25fc3b455d522d8dcc10a0f4c80	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	3.5.4	\N	\N	4367332047
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-10-16 06:55:36.416856	82	MARK_RAN	7:890ae73712bc187a66c2813a724d037f	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	4367332047
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-10-16 06:55:36.424934	83	EXECUTED	7:0a211980d27fafe3ff50d19a3a29b538	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	4367332047
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-10-16 06:55:36.429157	84	MARK_RAN	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	4367332047
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-10-16 06:55:36.45143	85	EXECUTED	7:01c49302201bdf815b0a18d1f98a55dc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	4367332047
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2021-10-16 06:55:36.460653	86	EXECUTED	7:3dace6b144c11f53f1ad2c0361279b86	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	3.5.4	\N	\N	4367332047
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2021-10-16 06:55:36.482827	87	EXECUTED	7:578d0b92077eaf2ab95ad0ec087aa903	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	3.5.4	\N	\N	4367332047
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2021-10-16 06:55:36.507573	88	EXECUTED	7:c95abe90d962c57a09ecaee57972835d	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	3.5.4	\N	\N	4367332047
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-16 06:55:36.517539	89	EXECUTED	7:f1313bcc2994a5c4dc1062ed6d8282d3	addColumn tableName=REALM; customChange		\N	3.5.4	\N	\N	4367332047
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-16 06:55:36.527145	90	EXECUTED	7:90d763b52eaffebefbcbde55f269508b	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	3.5.4	\N	\N	4367332047
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-16 06:55:36.551061	91	EXECUTED	7:d554f0cb92b764470dccfa5e0014a7dd	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	4367332047
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-16 06:55:36.56232	92	EXECUTED	7:73193e3ab3c35cf0f37ccea3bf783764	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	3.5.4	\N	\N	4367332047
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-16 06:55:36.566411	93	MARK_RAN	7:90a1e74f92e9cbaa0c5eab80b8a037f3	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	4367332047
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-16 06:55:36.583705	94	EXECUTED	7:5b9248f29cd047c200083cc6d8388b16	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	4367332047
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-16 06:55:36.588177	95	MARK_RAN	7:64db59e44c374f13955489e8990d17a1	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	3.5.4	\N	\N	4367332047
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-10-16 06:55:36.597695	96	EXECUTED	7:329a578cdb43262fff975f0a7f6cda60	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	3.5.4	\N	\N	4367332047
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-16 06:55:36.650719	97	EXECUTED	7:fae0de241ac0fd0bbc2b380b85e4f567	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	4367332047
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-16 06:55:36.655211	98	MARK_RAN	7:075d54e9180f49bb0c64ca4218936e81	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	4367332047
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-16 06:55:36.665121	99	MARK_RAN	7:06499836520f4f6b3d05e35a59324910	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	4367332047
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-16 06:55:36.69036	100	EXECUTED	7:fad08e83c77d0171ec166bc9bc5d390a	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	4367332047
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-16 06:55:36.694851	101	MARK_RAN	7:3d2b23076e59c6f70bae703aa01be35b	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	4367332047
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-16 06:55:36.717843	102	EXECUTED	7:1a7f28ff8d9e53aeb879d76ea3d9341a	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	3.5.4	\N	\N	4367332047
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-10-16 06:55:36.723616	103	EXECUTED	7:2fd554456fed4a82c698c555c5b751b6	customChange		\N	3.5.4	\N	\N	4367332047
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2021-10-16 06:55:36.73323	104	EXECUTED	7:b06356d66c2790ecc2ae54ba0458397a	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	3.5.4	\N	\N	4367332047
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
master	ac60c68c-6deb-4cd0-84d6-cd27d61a6eb4	f
master	617e1dd5-d57f-479a-b602-bff1fcdce8ec	t
master	21d8a424-5f9f-4d92-a39e-f41184e302b5	t
master	a281e36b-c8b1-4d2a-8f98-58e72ab04972	t
master	da2e5ac9-dee5-4390-8e75-d818c7aa94c7	f
master	d5264321-1f38-4df7-ae7f-bd48ae833bb5	f
master	e3f935c2-99ad-4168-b6a2-232009e34a1f	t
master	99f32146-6455-4cdc-96d2-8c3b2d04a7e4	t
master	76629e6a-d49a-4b9a-9d09-7b80599739bd	f
react-marathon	69852b21-f51f-423c-884a-c36689effca5	f
react-marathon	425ae237-7da9-42fa-a319-c52cacd05960	t
react-marathon	b31ae683-a5d1-4c64-8b30-d8abbd312a62	t
react-marathon	8c5557f8-d97a-492e-b96a-bedbf6dc1d1c	t
react-marathon	d86d775c-eeb8-474c-b0aa-c2e97fc690b2	f
react-marathon	4ebf94d3-d087-41a2-aec1-0b08d8d63a28	f
react-marathon	32d54869-14fa-4e24-825d-531a61f0d28d	t
react-marathon	6fbcf08a-9fbc-4ae1-bb30-d0b07894cd87	t
react-marathon	e7cb4ef1-52e8-43e9-92ad-c45171fe5486	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
c63f674f-7046-468b-80cb-2ce724540674	master	f	${role_default-roles}	default-roles-master	master	\N	\N
7ab49848-9cb9-4c00-b817-75b2f4e143e3	master	f	${role_admin}	admin	master	\N	\N
8aec0440-b89c-409f-b35a-799962660dd9	master	f	${role_create-realm}	create-realm	master	\N	\N
37383584-6613-4e94-9f4b-c2813c66362e	6a8e5601-519e-43be-9442-3db44e3a095d	t	${role_create-client}	create-client	master	6a8e5601-519e-43be-9442-3db44e3a095d	\N
bfba0c41-1d0a-4384-a98c-e04e0160f512	6a8e5601-519e-43be-9442-3db44e3a095d	t	${role_view-realm}	view-realm	master	6a8e5601-519e-43be-9442-3db44e3a095d	\N
a459dd2e-8150-4673-819a-54921d371d5f	6a8e5601-519e-43be-9442-3db44e3a095d	t	${role_view-users}	view-users	master	6a8e5601-519e-43be-9442-3db44e3a095d	\N
143055b1-ef3f-4470-8fd9-2719e26f9179	6a8e5601-519e-43be-9442-3db44e3a095d	t	${role_view-clients}	view-clients	master	6a8e5601-519e-43be-9442-3db44e3a095d	\N
6ba5ec2c-f525-448f-9478-7efffec9bfd6	6a8e5601-519e-43be-9442-3db44e3a095d	t	${role_view-events}	view-events	master	6a8e5601-519e-43be-9442-3db44e3a095d	\N
fa20a8d0-a645-4a80-a00c-af887810029f	6a8e5601-519e-43be-9442-3db44e3a095d	t	${role_view-identity-providers}	view-identity-providers	master	6a8e5601-519e-43be-9442-3db44e3a095d	\N
6674e620-5761-4918-90e8-10111b882d10	6a8e5601-519e-43be-9442-3db44e3a095d	t	${role_view-authorization}	view-authorization	master	6a8e5601-519e-43be-9442-3db44e3a095d	\N
2c7f8fe2-84cd-4955-acf8-2444fbc44eae	6a8e5601-519e-43be-9442-3db44e3a095d	t	${role_manage-realm}	manage-realm	master	6a8e5601-519e-43be-9442-3db44e3a095d	\N
f88188f3-4dcb-48a4-bb3a-2ba34ec1cec5	6a8e5601-519e-43be-9442-3db44e3a095d	t	${role_manage-users}	manage-users	master	6a8e5601-519e-43be-9442-3db44e3a095d	\N
432b9a79-bd29-4c7f-91a4-465e70f6b7a4	6a8e5601-519e-43be-9442-3db44e3a095d	t	${role_manage-clients}	manage-clients	master	6a8e5601-519e-43be-9442-3db44e3a095d	\N
41f8514c-6cfc-42c4-8c45-6d379b45fd09	6a8e5601-519e-43be-9442-3db44e3a095d	t	${role_manage-events}	manage-events	master	6a8e5601-519e-43be-9442-3db44e3a095d	\N
8e2a6b77-7ad2-4fb9-8427-4ba77f3fe036	6a8e5601-519e-43be-9442-3db44e3a095d	t	${role_manage-identity-providers}	manage-identity-providers	master	6a8e5601-519e-43be-9442-3db44e3a095d	\N
a3242760-e863-45a7-8e24-fbb33c39fc5a	6a8e5601-519e-43be-9442-3db44e3a095d	t	${role_manage-authorization}	manage-authorization	master	6a8e5601-519e-43be-9442-3db44e3a095d	\N
2302679b-3499-4387-a19a-6b5772c48d4e	6a8e5601-519e-43be-9442-3db44e3a095d	t	${role_query-users}	query-users	master	6a8e5601-519e-43be-9442-3db44e3a095d	\N
1dc53b69-08fa-419b-bab9-d8d0db8e2bef	6a8e5601-519e-43be-9442-3db44e3a095d	t	${role_query-clients}	query-clients	master	6a8e5601-519e-43be-9442-3db44e3a095d	\N
3dd6d00e-ecfa-44b0-b463-e6308e2a5eec	6a8e5601-519e-43be-9442-3db44e3a095d	t	${role_query-realms}	query-realms	master	6a8e5601-519e-43be-9442-3db44e3a095d	\N
a6714763-9454-41a2-b385-74bfb9cc5817	6a8e5601-519e-43be-9442-3db44e3a095d	t	${role_query-groups}	query-groups	master	6a8e5601-519e-43be-9442-3db44e3a095d	\N
cf7ef87b-e49a-4547-838f-0fd9bdb765ab	4d63cc93-ee21-4b8e-93e0-6b0db0612efa	t	${role_view-profile}	view-profile	master	4d63cc93-ee21-4b8e-93e0-6b0db0612efa	\N
a7a0cf19-fff5-4693-93fb-7c7d6ca37f30	4d63cc93-ee21-4b8e-93e0-6b0db0612efa	t	${role_manage-account}	manage-account	master	4d63cc93-ee21-4b8e-93e0-6b0db0612efa	\N
a2dde0e3-98b7-4760-93da-09cb0a1b4b3c	4d63cc93-ee21-4b8e-93e0-6b0db0612efa	t	${role_manage-account-links}	manage-account-links	master	4d63cc93-ee21-4b8e-93e0-6b0db0612efa	\N
ccdfced2-8629-4814-bc7a-564dd4f62dab	4d63cc93-ee21-4b8e-93e0-6b0db0612efa	t	${role_view-applications}	view-applications	master	4d63cc93-ee21-4b8e-93e0-6b0db0612efa	\N
3d1f04a2-a373-479c-bd9d-cb19a338ea0f	4d63cc93-ee21-4b8e-93e0-6b0db0612efa	t	${role_view-consent}	view-consent	master	4d63cc93-ee21-4b8e-93e0-6b0db0612efa	\N
d9497595-06ca-47b4-a4b1-bf99189fdc02	4d63cc93-ee21-4b8e-93e0-6b0db0612efa	t	${role_manage-consent}	manage-consent	master	4d63cc93-ee21-4b8e-93e0-6b0db0612efa	\N
2c481f7a-8130-4e03-abc6-1f07a3ec3e14	4d63cc93-ee21-4b8e-93e0-6b0db0612efa	t	${role_delete-account}	delete-account	master	4d63cc93-ee21-4b8e-93e0-6b0db0612efa	\N
e50ff3a9-043c-45c4-82d0-8e7975d797c1	14cf6353-f9c7-4212-9a4e-6195ab31ac50	t	${role_read-token}	read-token	master	14cf6353-f9c7-4212-9a4e-6195ab31ac50	\N
425536d0-bac9-4748-a437-7c89b8eba599	6a8e5601-519e-43be-9442-3db44e3a095d	t	${role_impersonation}	impersonation	master	6a8e5601-519e-43be-9442-3db44e3a095d	\N
1ed40bcd-384c-4228-9af8-59f3cd67d87c	master	f	${role_offline-access}	offline_access	master	\N	\N
5e48e552-8816-4904-a586-71a938d486ce	master	f	${role_uma_authorization}	uma_authorization	master	\N	\N
08c3b01c-f2b9-400a-932b-8aa54d076168	react-marathon	f	${role_default-roles}	default-roles-react-marathon	react-marathon	\N	\N
87654c08-d465-4617-80bf-8ef268aeac0a	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	t	${role_create-client}	create-client	master	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	\N
41af9949-9649-4f20-8354-e3ec46bf44e4	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	t	${role_view-realm}	view-realm	master	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	\N
2c3b8020-3978-4b15-a045-1afbe0fa91cb	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	t	${role_view-users}	view-users	master	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	\N
17eb16f1-b4c7-4ea6-b50f-1e2d583009c5	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	t	${role_view-clients}	view-clients	master	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	\N
843453a0-55aa-4bc1-b4e8-0c2cfd79f683	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	t	${role_view-events}	view-events	master	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	\N
8b86192f-211f-4c7c-a013-7e75b155f861	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	t	${role_view-identity-providers}	view-identity-providers	master	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	\N
056fbcf6-2912-47b7-b0eb-7b30ea0ec045	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	t	${role_view-authorization}	view-authorization	master	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	\N
f360b96d-65cc-4d2d-9fff-e095032703d1	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	t	${role_manage-realm}	manage-realm	master	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	\N
c6862cd8-5cda-4d69-837e-0be7086f6365	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	t	${role_manage-users}	manage-users	master	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	\N
9ae8a7c9-449f-4792-8520-32f7a6d4e616	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	t	${role_manage-clients}	manage-clients	master	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	\N
ea9f5642-1174-4f3a-a0bf-f1e199e5b5a3	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	t	${role_manage-events}	manage-events	master	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	\N
35f9246a-fef9-404d-97a8-dafd6fc37875	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	t	${role_manage-identity-providers}	manage-identity-providers	master	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	\N
dd25c379-a83b-4bb7-a8c6-5ba81f4e0d34	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	t	${role_manage-authorization}	manage-authorization	master	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	\N
dc29cf4a-b081-4ad9-af1f-a913d10c15a7	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	t	${role_query-users}	query-users	master	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	\N
5d964daf-6ef2-4f44-853e-5fc12aaca564	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	t	${role_query-clients}	query-clients	master	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	\N
51272787-e3af-44eb-830d-cb6726f02728	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	t	${role_query-realms}	query-realms	master	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	\N
eb87a519-9433-47a4-99cc-2fd04558315d	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	t	${role_query-groups}	query-groups	master	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	\N
40636fd6-976e-4b8a-984c-44edc3ed6234	32ea06f4-2f54-44e8-a08d-ee37835e161e	t	${role_realm-admin}	realm-admin	react-marathon	32ea06f4-2f54-44e8-a08d-ee37835e161e	\N
7dd70717-55ea-47d7-b218-a912c571064f	32ea06f4-2f54-44e8-a08d-ee37835e161e	t	${role_create-client}	create-client	react-marathon	32ea06f4-2f54-44e8-a08d-ee37835e161e	\N
730844ae-ee13-4c8c-bb6a-aec5146f97cb	32ea06f4-2f54-44e8-a08d-ee37835e161e	t	${role_view-realm}	view-realm	react-marathon	32ea06f4-2f54-44e8-a08d-ee37835e161e	\N
b015fd6f-2f3a-439d-82cb-e1e390af05e0	32ea06f4-2f54-44e8-a08d-ee37835e161e	t	${role_view-users}	view-users	react-marathon	32ea06f4-2f54-44e8-a08d-ee37835e161e	\N
3e4c2423-4376-4ac4-9f86-63cfef26a56b	32ea06f4-2f54-44e8-a08d-ee37835e161e	t	${role_view-clients}	view-clients	react-marathon	32ea06f4-2f54-44e8-a08d-ee37835e161e	\N
a803c277-c72d-43da-9b59-9644cde63cc6	32ea06f4-2f54-44e8-a08d-ee37835e161e	t	${role_view-events}	view-events	react-marathon	32ea06f4-2f54-44e8-a08d-ee37835e161e	\N
be50ca12-a9c7-46b4-823c-dc23739032c2	32ea06f4-2f54-44e8-a08d-ee37835e161e	t	${role_view-identity-providers}	view-identity-providers	react-marathon	32ea06f4-2f54-44e8-a08d-ee37835e161e	\N
8ccd7ff6-3133-49e9-b50e-2a7c05b9d538	32ea06f4-2f54-44e8-a08d-ee37835e161e	t	${role_view-authorization}	view-authorization	react-marathon	32ea06f4-2f54-44e8-a08d-ee37835e161e	\N
58f21d5c-994a-4c1f-af03-bc7f06f2e889	32ea06f4-2f54-44e8-a08d-ee37835e161e	t	${role_manage-realm}	manage-realm	react-marathon	32ea06f4-2f54-44e8-a08d-ee37835e161e	\N
656131d5-19d4-45ee-a58e-6e607a6ae549	32ea06f4-2f54-44e8-a08d-ee37835e161e	t	${role_manage-users}	manage-users	react-marathon	32ea06f4-2f54-44e8-a08d-ee37835e161e	\N
46f9b6fd-5d6b-449c-b57e-8522c65d7a6f	32ea06f4-2f54-44e8-a08d-ee37835e161e	t	${role_manage-clients}	manage-clients	react-marathon	32ea06f4-2f54-44e8-a08d-ee37835e161e	\N
8353c43b-8504-4c0b-ad5e-4ce769bed0be	32ea06f4-2f54-44e8-a08d-ee37835e161e	t	${role_manage-events}	manage-events	react-marathon	32ea06f4-2f54-44e8-a08d-ee37835e161e	\N
051f1e08-e137-4dff-aff7-e1be9eba7a55	32ea06f4-2f54-44e8-a08d-ee37835e161e	t	${role_manage-identity-providers}	manage-identity-providers	react-marathon	32ea06f4-2f54-44e8-a08d-ee37835e161e	\N
09e51aad-9056-4b9c-a522-220ec5ee7f06	32ea06f4-2f54-44e8-a08d-ee37835e161e	t	${role_manage-authorization}	manage-authorization	react-marathon	32ea06f4-2f54-44e8-a08d-ee37835e161e	\N
3df43416-8374-403d-81b1-7baa4d5d5661	32ea06f4-2f54-44e8-a08d-ee37835e161e	t	${role_query-users}	query-users	react-marathon	32ea06f4-2f54-44e8-a08d-ee37835e161e	\N
18d4ddfd-0810-4b07-8062-470a513b94ee	32ea06f4-2f54-44e8-a08d-ee37835e161e	t	${role_query-clients}	query-clients	react-marathon	32ea06f4-2f54-44e8-a08d-ee37835e161e	\N
905c7581-47b0-498c-8360-311c0990802d	32ea06f4-2f54-44e8-a08d-ee37835e161e	t	${role_query-realms}	query-realms	react-marathon	32ea06f4-2f54-44e8-a08d-ee37835e161e	\N
3480dcb4-1113-4f34-b5ce-b192f033666d	32ea06f4-2f54-44e8-a08d-ee37835e161e	t	${role_query-groups}	query-groups	react-marathon	32ea06f4-2f54-44e8-a08d-ee37835e161e	\N
49b9e494-a292-4733-a4d1-efbae6af86e9	72c97257-a124-4449-b005-541f7c4a3f47	t	${role_view-profile}	view-profile	react-marathon	72c97257-a124-4449-b005-541f7c4a3f47	\N
f8cd713c-e194-4ba4-b08f-1ca0b0e9a612	72c97257-a124-4449-b005-541f7c4a3f47	t	${role_manage-account}	manage-account	react-marathon	72c97257-a124-4449-b005-541f7c4a3f47	\N
1e851f6a-380c-48ed-a3ae-a7536f8cbd22	72c97257-a124-4449-b005-541f7c4a3f47	t	${role_manage-account-links}	manage-account-links	react-marathon	72c97257-a124-4449-b005-541f7c4a3f47	\N
5bd92656-14d1-41f3-b348-a906095c5bcf	72c97257-a124-4449-b005-541f7c4a3f47	t	${role_view-applications}	view-applications	react-marathon	72c97257-a124-4449-b005-541f7c4a3f47	\N
96fb14e2-453b-4e5b-aea2-c9806684ebcd	72c97257-a124-4449-b005-541f7c4a3f47	t	${role_view-consent}	view-consent	react-marathon	72c97257-a124-4449-b005-541f7c4a3f47	\N
0c1d9677-bfa6-4e85-bb89-cf0f4e08943e	72c97257-a124-4449-b005-541f7c4a3f47	t	${role_manage-consent}	manage-consent	react-marathon	72c97257-a124-4449-b005-541f7c4a3f47	\N
7c8cd508-2533-4aa3-a344-cef9333b2379	72c97257-a124-4449-b005-541f7c4a3f47	t	${role_delete-account}	delete-account	react-marathon	72c97257-a124-4449-b005-541f7c4a3f47	\N
f836f04a-a3b8-409c-bd43-57b76e26a622	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	t	${role_impersonation}	impersonation	master	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	\N
ec719926-474e-4ac8-8fff-4d68ebce32ab	32ea06f4-2f54-44e8-a08d-ee37835e161e	t	${role_impersonation}	impersonation	react-marathon	32ea06f4-2f54-44e8-a08d-ee37835e161e	\N
6e9cafd8-ad52-4ab6-a22c-1a92bf01cc81	454d240b-90b5-4464-ab66-ff684ca7b9f4	t	${role_read-token}	read-token	react-marathon	454d240b-90b5-4464-ab66-ff684ca7b9f4	\N
8b25c2be-145c-4015-96d1-639ea689d2aa	react-marathon	f	${role_offline-access}	offline_access	react-marathon	\N	\N
755b6afc-7112-4bd6-9ef1-8b0ab3c3de65	react-marathon	f	${role_uma_authorization}	uma_authorization	react-marathon	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.migration_model (id, version, update_time) FROM stdin;
vfxqj	15.0.2	1634367339
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
5fb253a0-9013-4e2c-823d-9f58c2c3a9ab	audience resolve	openid-connect	oidc-audience-resolve-mapper	e8a8e7cc-5170-46b8-a979-86b100349a5e	\N
42f47e4b-2e74-489f-a130-2ede0f096adc	locale	openid-connect	oidc-usermodel-attribute-mapper	5d8d60cd-2275-4624-a83b-0cc2489052df	\N
83777702-2bc7-419a-adfc-5e7d42409f76	role list	saml	saml-role-list-mapper	\N	617e1dd5-d57f-479a-b602-bff1fcdce8ec
ca47ce62-e33e-40bb-895b-d0af7853cafc	full name	openid-connect	oidc-full-name-mapper	\N	21d8a424-5f9f-4d92-a39e-f41184e302b5
fba8b4ba-30b3-4f65-80e9-fd5eb8e21d3c	family name	openid-connect	oidc-usermodel-property-mapper	\N	21d8a424-5f9f-4d92-a39e-f41184e302b5
2d2cc1db-3ee1-4f97-ba9b-834e109a947e	given name	openid-connect	oidc-usermodel-property-mapper	\N	21d8a424-5f9f-4d92-a39e-f41184e302b5
743040ce-b97e-4e4f-9a67-871509c40d46	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	21d8a424-5f9f-4d92-a39e-f41184e302b5
97a8b043-c8eb-4325-8dd3-df51707d8e6c	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	21d8a424-5f9f-4d92-a39e-f41184e302b5
85e7b167-607a-4ab1-a082-736dc6ae680e	username	openid-connect	oidc-usermodel-property-mapper	\N	21d8a424-5f9f-4d92-a39e-f41184e302b5
77ea8535-dd44-4ab4-81be-15b5fa8188d8	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	21d8a424-5f9f-4d92-a39e-f41184e302b5
e595a050-3b1c-4b5b-b4fa-ab578b742c0d	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	21d8a424-5f9f-4d92-a39e-f41184e302b5
88a67fc3-d6a2-44d3-93cf-043e4dae95d0	website	openid-connect	oidc-usermodel-attribute-mapper	\N	21d8a424-5f9f-4d92-a39e-f41184e302b5
273a87af-b632-4ca9-a509-5e835fa0fb7d	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	21d8a424-5f9f-4d92-a39e-f41184e302b5
5a61fd65-ddab-4d96-9d9f-ee7baed543c4	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	21d8a424-5f9f-4d92-a39e-f41184e302b5
9b7dd068-e5f3-40a5-85ef-e0e6ebb0f4bd	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	21d8a424-5f9f-4d92-a39e-f41184e302b5
b55e064c-fce4-4ef8-9d01-8d1854a73c05	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	21d8a424-5f9f-4d92-a39e-f41184e302b5
36f258b9-dde8-4810-b16a-e0e335e30c2f	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	21d8a424-5f9f-4d92-a39e-f41184e302b5
36708fe0-4b73-4f0c-bdd6-19be1a46d363	email	openid-connect	oidc-usermodel-property-mapper	\N	a281e36b-c8b1-4d2a-8f98-58e72ab04972
18229473-34b5-4ed4-9103-414755d60aea	email verified	openid-connect	oidc-usermodel-property-mapper	\N	a281e36b-c8b1-4d2a-8f98-58e72ab04972
cc536c6d-f131-4846-9ae5-daab8719a34f	address	openid-connect	oidc-address-mapper	\N	da2e5ac9-dee5-4390-8e75-d818c7aa94c7
2fac9a39-af43-486c-9246-ecda93da3049	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	d5264321-1f38-4df7-ae7f-bd48ae833bb5
c98a5cb9-7a4d-4170-b5f0-7c8150b84347	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	d5264321-1f38-4df7-ae7f-bd48ae833bb5
94b173e8-7534-4401-8d1e-c3aa07ce40b5	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	e3f935c2-99ad-4168-b6a2-232009e34a1f
83f06f35-18cf-4108-953a-1c3512083f72	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	e3f935c2-99ad-4168-b6a2-232009e34a1f
bf094c00-964f-4ffc-9649-15415d327cad	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	e3f935c2-99ad-4168-b6a2-232009e34a1f
a27b42b2-8479-42b2-9798-e691c2fa0dbc	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	99f32146-6455-4cdc-96d2-8c3b2d04a7e4
c69d0db1-aa8d-4c05-8957-e47ea9aeb91a	upn	openid-connect	oidc-usermodel-property-mapper	\N	76629e6a-d49a-4b9a-9d09-7b80599739bd
d0d297ad-5fc7-4fe6-8474-b45db7a2e870	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	76629e6a-d49a-4b9a-9d09-7b80599739bd
d57442ee-657e-4d3b-825c-8f87050cdf34	audience resolve	openid-connect	oidc-audience-resolve-mapper	d0ac1d0b-848b-4beb-8203-7c7ac2ec867b	\N
928f6233-e359-447d-aa39-7c842311b97b	role list	saml	saml-role-list-mapper	\N	425ae237-7da9-42fa-a319-c52cacd05960
793ee0b8-4b2e-462c-9aaf-816b7c65927a	full name	openid-connect	oidc-full-name-mapper	\N	b31ae683-a5d1-4c64-8b30-d8abbd312a62
337fd800-6fa5-4661-9439-cc6b8e04a280	family name	openid-connect	oidc-usermodel-property-mapper	\N	b31ae683-a5d1-4c64-8b30-d8abbd312a62
5207cf5b-c0b8-4c94-bed3-47868acfc1ad	given name	openid-connect	oidc-usermodel-property-mapper	\N	b31ae683-a5d1-4c64-8b30-d8abbd312a62
db9db369-59d7-46cb-a865-c4b95941c096	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	b31ae683-a5d1-4c64-8b30-d8abbd312a62
468554e0-0287-4218-ae76-f59c58c3d4da	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	b31ae683-a5d1-4c64-8b30-d8abbd312a62
11a06d38-d5e4-4ff6-9702-097fc9f367d0	username	openid-connect	oidc-usermodel-property-mapper	\N	b31ae683-a5d1-4c64-8b30-d8abbd312a62
5dacb5cf-debd-42af-a249-316f22c48ed9	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	b31ae683-a5d1-4c64-8b30-d8abbd312a62
26c9c69f-462f-4c34-8b77-8559c9b9e334	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	b31ae683-a5d1-4c64-8b30-d8abbd312a62
bb61fc65-2cd4-42cb-8553-ff162d3e64fe	website	openid-connect	oidc-usermodel-attribute-mapper	\N	b31ae683-a5d1-4c64-8b30-d8abbd312a62
9fd8ed24-9692-4395-99d0-f0869ff7c40b	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	b31ae683-a5d1-4c64-8b30-d8abbd312a62
9f1d6790-020c-460d-831b-836d2023944a	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	b31ae683-a5d1-4c64-8b30-d8abbd312a62
ffa07e3c-699c-4adc-8488-fd8f1740381d	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	b31ae683-a5d1-4c64-8b30-d8abbd312a62
4bef9b50-bfe5-4cf0-82af-f7f842608734	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	b31ae683-a5d1-4c64-8b30-d8abbd312a62
89a131f6-f732-4d2d-b809-e5c19f444317	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	b31ae683-a5d1-4c64-8b30-d8abbd312a62
306799bc-75a8-4e82-9170-50a59bd4ba50	email	openid-connect	oidc-usermodel-property-mapper	\N	8c5557f8-d97a-492e-b96a-bedbf6dc1d1c
d34ca088-d676-4173-8fe7-61e0dca5c13d	email verified	openid-connect	oidc-usermodel-property-mapper	\N	8c5557f8-d97a-492e-b96a-bedbf6dc1d1c
63716c97-c03a-42a6-94c6-127953a9598d	address	openid-connect	oidc-address-mapper	\N	d86d775c-eeb8-474c-b0aa-c2e97fc690b2
7ea7c153-d4ca-4f5a-8c49-840aaf6b8292	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	4ebf94d3-d087-41a2-aec1-0b08d8d63a28
947485b5-3dd7-4e3b-90ea-e247cae5e27c	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	4ebf94d3-d087-41a2-aec1-0b08d8d63a28
6640d928-5f26-4fa4-913d-b85517aa83d3	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	32d54869-14fa-4e24-825d-531a61f0d28d
3c1d6054-08e9-4e74-9bf9-5794757c1b3b	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	32d54869-14fa-4e24-825d-531a61f0d28d
8a744e09-f28a-4637-99cc-27c6bc596141	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	32d54869-14fa-4e24-825d-531a61f0d28d
380229c6-e729-474e-bc7f-7c39964b98ae	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	6fbcf08a-9fbc-4ae1-bb30-d0b07894cd87
5ae71840-5e71-492d-8a30-867ed186e312	upn	openid-connect	oidc-usermodel-property-mapper	\N	e7cb4ef1-52e8-43e9-92ad-c45171fe5486
633d4992-91f4-432a-a78a-0a26085b19dd	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	e7cb4ef1-52e8-43e9-92ad-c45171fe5486
50890e10-ba22-4b12-8eab-0fcb940cdb68	locale	openid-connect	oidc-usermodel-attribute-mapper	9a237619-9551-42d8-93d6-2382c2236bd5	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
42f47e4b-2e74-489f-a130-2ede0f096adc	true	userinfo.token.claim
42f47e4b-2e74-489f-a130-2ede0f096adc	locale	user.attribute
42f47e4b-2e74-489f-a130-2ede0f096adc	true	id.token.claim
42f47e4b-2e74-489f-a130-2ede0f096adc	true	access.token.claim
42f47e4b-2e74-489f-a130-2ede0f096adc	locale	claim.name
42f47e4b-2e74-489f-a130-2ede0f096adc	String	jsonType.label
83777702-2bc7-419a-adfc-5e7d42409f76	false	single
83777702-2bc7-419a-adfc-5e7d42409f76	Basic	attribute.nameformat
83777702-2bc7-419a-adfc-5e7d42409f76	Role	attribute.name
ca47ce62-e33e-40bb-895b-d0af7853cafc	true	userinfo.token.claim
ca47ce62-e33e-40bb-895b-d0af7853cafc	true	id.token.claim
ca47ce62-e33e-40bb-895b-d0af7853cafc	true	access.token.claim
fba8b4ba-30b3-4f65-80e9-fd5eb8e21d3c	true	userinfo.token.claim
fba8b4ba-30b3-4f65-80e9-fd5eb8e21d3c	lastName	user.attribute
fba8b4ba-30b3-4f65-80e9-fd5eb8e21d3c	true	id.token.claim
fba8b4ba-30b3-4f65-80e9-fd5eb8e21d3c	true	access.token.claim
fba8b4ba-30b3-4f65-80e9-fd5eb8e21d3c	family_name	claim.name
fba8b4ba-30b3-4f65-80e9-fd5eb8e21d3c	String	jsonType.label
2d2cc1db-3ee1-4f97-ba9b-834e109a947e	true	userinfo.token.claim
2d2cc1db-3ee1-4f97-ba9b-834e109a947e	firstName	user.attribute
2d2cc1db-3ee1-4f97-ba9b-834e109a947e	true	id.token.claim
2d2cc1db-3ee1-4f97-ba9b-834e109a947e	true	access.token.claim
2d2cc1db-3ee1-4f97-ba9b-834e109a947e	given_name	claim.name
2d2cc1db-3ee1-4f97-ba9b-834e109a947e	String	jsonType.label
743040ce-b97e-4e4f-9a67-871509c40d46	true	userinfo.token.claim
743040ce-b97e-4e4f-9a67-871509c40d46	middleName	user.attribute
743040ce-b97e-4e4f-9a67-871509c40d46	true	id.token.claim
743040ce-b97e-4e4f-9a67-871509c40d46	true	access.token.claim
743040ce-b97e-4e4f-9a67-871509c40d46	middle_name	claim.name
743040ce-b97e-4e4f-9a67-871509c40d46	String	jsonType.label
97a8b043-c8eb-4325-8dd3-df51707d8e6c	true	userinfo.token.claim
97a8b043-c8eb-4325-8dd3-df51707d8e6c	nickname	user.attribute
97a8b043-c8eb-4325-8dd3-df51707d8e6c	true	id.token.claim
97a8b043-c8eb-4325-8dd3-df51707d8e6c	true	access.token.claim
97a8b043-c8eb-4325-8dd3-df51707d8e6c	nickname	claim.name
97a8b043-c8eb-4325-8dd3-df51707d8e6c	String	jsonType.label
85e7b167-607a-4ab1-a082-736dc6ae680e	true	userinfo.token.claim
85e7b167-607a-4ab1-a082-736dc6ae680e	username	user.attribute
85e7b167-607a-4ab1-a082-736dc6ae680e	true	id.token.claim
85e7b167-607a-4ab1-a082-736dc6ae680e	true	access.token.claim
85e7b167-607a-4ab1-a082-736dc6ae680e	preferred_username	claim.name
85e7b167-607a-4ab1-a082-736dc6ae680e	String	jsonType.label
77ea8535-dd44-4ab4-81be-15b5fa8188d8	true	userinfo.token.claim
77ea8535-dd44-4ab4-81be-15b5fa8188d8	profile	user.attribute
77ea8535-dd44-4ab4-81be-15b5fa8188d8	true	id.token.claim
77ea8535-dd44-4ab4-81be-15b5fa8188d8	true	access.token.claim
77ea8535-dd44-4ab4-81be-15b5fa8188d8	profile	claim.name
77ea8535-dd44-4ab4-81be-15b5fa8188d8	String	jsonType.label
e595a050-3b1c-4b5b-b4fa-ab578b742c0d	true	userinfo.token.claim
e595a050-3b1c-4b5b-b4fa-ab578b742c0d	picture	user.attribute
e595a050-3b1c-4b5b-b4fa-ab578b742c0d	true	id.token.claim
e595a050-3b1c-4b5b-b4fa-ab578b742c0d	true	access.token.claim
e595a050-3b1c-4b5b-b4fa-ab578b742c0d	picture	claim.name
e595a050-3b1c-4b5b-b4fa-ab578b742c0d	String	jsonType.label
88a67fc3-d6a2-44d3-93cf-043e4dae95d0	true	userinfo.token.claim
88a67fc3-d6a2-44d3-93cf-043e4dae95d0	website	user.attribute
88a67fc3-d6a2-44d3-93cf-043e4dae95d0	true	id.token.claim
88a67fc3-d6a2-44d3-93cf-043e4dae95d0	true	access.token.claim
88a67fc3-d6a2-44d3-93cf-043e4dae95d0	website	claim.name
88a67fc3-d6a2-44d3-93cf-043e4dae95d0	String	jsonType.label
273a87af-b632-4ca9-a509-5e835fa0fb7d	true	userinfo.token.claim
273a87af-b632-4ca9-a509-5e835fa0fb7d	gender	user.attribute
273a87af-b632-4ca9-a509-5e835fa0fb7d	true	id.token.claim
273a87af-b632-4ca9-a509-5e835fa0fb7d	true	access.token.claim
273a87af-b632-4ca9-a509-5e835fa0fb7d	gender	claim.name
273a87af-b632-4ca9-a509-5e835fa0fb7d	String	jsonType.label
5a61fd65-ddab-4d96-9d9f-ee7baed543c4	true	userinfo.token.claim
5a61fd65-ddab-4d96-9d9f-ee7baed543c4	birthdate	user.attribute
5a61fd65-ddab-4d96-9d9f-ee7baed543c4	true	id.token.claim
5a61fd65-ddab-4d96-9d9f-ee7baed543c4	true	access.token.claim
5a61fd65-ddab-4d96-9d9f-ee7baed543c4	birthdate	claim.name
5a61fd65-ddab-4d96-9d9f-ee7baed543c4	String	jsonType.label
9b7dd068-e5f3-40a5-85ef-e0e6ebb0f4bd	true	userinfo.token.claim
9b7dd068-e5f3-40a5-85ef-e0e6ebb0f4bd	zoneinfo	user.attribute
9b7dd068-e5f3-40a5-85ef-e0e6ebb0f4bd	true	id.token.claim
9b7dd068-e5f3-40a5-85ef-e0e6ebb0f4bd	true	access.token.claim
9b7dd068-e5f3-40a5-85ef-e0e6ebb0f4bd	zoneinfo	claim.name
9b7dd068-e5f3-40a5-85ef-e0e6ebb0f4bd	String	jsonType.label
b55e064c-fce4-4ef8-9d01-8d1854a73c05	true	userinfo.token.claim
b55e064c-fce4-4ef8-9d01-8d1854a73c05	locale	user.attribute
b55e064c-fce4-4ef8-9d01-8d1854a73c05	true	id.token.claim
b55e064c-fce4-4ef8-9d01-8d1854a73c05	true	access.token.claim
b55e064c-fce4-4ef8-9d01-8d1854a73c05	locale	claim.name
b55e064c-fce4-4ef8-9d01-8d1854a73c05	String	jsonType.label
36f258b9-dde8-4810-b16a-e0e335e30c2f	true	userinfo.token.claim
36f258b9-dde8-4810-b16a-e0e335e30c2f	updatedAt	user.attribute
36f258b9-dde8-4810-b16a-e0e335e30c2f	true	id.token.claim
36f258b9-dde8-4810-b16a-e0e335e30c2f	true	access.token.claim
36f258b9-dde8-4810-b16a-e0e335e30c2f	updated_at	claim.name
36f258b9-dde8-4810-b16a-e0e335e30c2f	String	jsonType.label
36708fe0-4b73-4f0c-bdd6-19be1a46d363	true	userinfo.token.claim
36708fe0-4b73-4f0c-bdd6-19be1a46d363	email	user.attribute
36708fe0-4b73-4f0c-bdd6-19be1a46d363	true	id.token.claim
36708fe0-4b73-4f0c-bdd6-19be1a46d363	true	access.token.claim
36708fe0-4b73-4f0c-bdd6-19be1a46d363	email	claim.name
36708fe0-4b73-4f0c-bdd6-19be1a46d363	String	jsonType.label
18229473-34b5-4ed4-9103-414755d60aea	true	userinfo.token.claim
18229473-34b5-4ed4-9103-414755d60aea	emailVerified	user.attribute
18229473-34b5-4ed4-9103-414755d60aea	true	id.token.claim
18229473-34b5-4ed4-9103-414755d60aea	true	access.token.claim
18229473-34b5-4ed4-9103-414755d60aea	email_verified	claim.name
18229473-34b5-4ed4-9103-414755d60aea	boolean	jsonType.label
cc536c6d-f131-4846-9ae5-daab8719a34f	formatted	user.attribute.formatted
cc536c6d-f131-4846-9ae5-daab8719a34f	country	user.attribute.country
cc536c6d-f131-4846-9ae5-daab8719a34f	postal_code	user.attribute.postal_code
cc536c6d-f131-4846-9ae5-daab8719a34f	true	userinfo.token.claim
cc536c6d-f131-4846-9ae5-daab8719a34f	street	user.attribute.street
cc536c6d-f131-4846-9ae5-daab8719a34f	true	id.token.claim
cc536c6d-f131-4846-9ae5-daab8719a34f	region	user.attribute.region
cc536c6d-f131-4846-9ae5-daab8719a34f	true	access.token.claim
cc536c6d-f131-4846-9ae5-daab8719a34f	locality	user.attribute.locality
2fac9a39-af43-486c-9246-ecda93da3049	true	userinfo.token.claim
2fac9a39-af43-486c-9246-ecda93da3049	phoneNumber	user.attribute
2fac9a39-af43-486c-9246-ecda93da3049	true	id.token.claim
2fac9a39-af43-486c-9246-ecda93da3049	true	access.token.claim
2fac9a39-af43-486c-9246-ecda93da3049	phone_number	claim.name
2fac9a39-af43-486c-9246-ecda93da3049	String	jsonType.label
c98a5cb9-7a4d-4170-b5f0-7c8150b84347	true	userinfo.token.claim
c98a5cb9-7a4d-4170-b5f0-7c8150b84347	phoneNumberVerified	user.attribute
c98a5cb9-7a4d-4170-b5f0-7c8150b84347	true	id.token.claim
c98a5cb9-7a4d-4170-b5f0-7c8150b84347	true	access.token.claim
c98a5cb9-7a4d-4170-b5f0-7c8150b84347	phone_number_verified	claim.name
c98a5cb9-7a4d-4170-b5f0-7c8150b84347	boolean	jsonType.label
94b173e8-7534-4401-8d1e-c3aa07ce40b5	true	multivalued
94b173e8-7534-4401-8d1e-c3aa07ce40b5	foo	user.attribute
94b173e8-7534-4401-8d1e-c3aa07ce40b5	true	access.token.claim
94b173e8-7534-4401-8d1e-c3aa07ce40b5	realm_access.roles	claim.name
94b173e8-7534-4401-8d1e-c3aa07ce40b5	String	jsonType.label
83f06f35-18cf-4108-953a-1c3512083f72	true	multivalued
83f06f35-18cf-4108-953a-1c3512083f72	foo	user.attribute
83f06f35-18cf-4108-953a-1c3512083f72	true	access.token.claim
83f06f35-18cf-4108-953a-1c3512083f72	resource_access.${client_id}.roles	claim.name
83f06f35-18cf-4108-953a-1c3512083f72	String	jsonType.label
c69d0db1-aa8d-4c05-8957-e47ea9aeb91a	true	userinfo.token.claim
c69d0db1-aa8d-4c05-8957-e47ea9aeb91a	username	user.attribute
c69d0db1-aa8d-4c05-8957-e47ea9aeb91a	true	id.token.claim
c69d0db1-aa8d-4c05-8957-e47ea9aeb91a	true	access.token.claim
c69d0db1-aa8d-4c05-8957-e47ea9aeb91a	upn	claim.name
c69d0db1-aa8d-4c05-8957-e47ea9aeb91a	String	jsonType.label
d0d297ad-5fc7-4fe6-8474-b45db7a2e870	true	multivalued
d0d297ad-5fc7-4fe6-8474-b45db7a2e870	foo	user.attribute
d0d297ad-5fc7-4fe6-8474-b45db7a2e870	true	id.token.claim
d0d297ad-5fc7-4fe6-8474-b45db7a2e870	true	access.token.claim
d0d297ad-5fc7-4fe6-8474-b45db7a2e870	groups	claim.name
d0d297ad-5fc7-4fe6-8474-b45db7a2e870	String	jsonType.label
928f6233-e359-447d-aa39-7c842311b97b	false	single
928f6233-e359-447d-aa39-7c842311b97b	Basic	attribute.nameformat
928f6233-e359-447d-aa39-7c842311b97b	Role	attribute.name
793ee0b8-4b2e-462c-9aaf-816b7c65927a	true	userinfo.token.claim
793ee0b8-4b2e-462c-9aaf-816b7c65927a	true	id.token.claim
793ee0b8-4b2e-462c-9aaf-816b7c65927a	true	access.token.claim
337fd800-6fa5-4661-9439-cc6b8e04a280	true	userinfo.token.claim
337fd800-6fa5-4661-9439-cc6b8e04a280	lastName	user.attribute
337fd800-6fa5-4661-9439-cc6b8e04a280	true	id.token.claim
337fd800-6fa5-4661-9439-cc6b8e04a280	true	access.token.claim
337fd800-6fa5-4661-9439-cc6b8e04a280	family_name	claim.name
337fd800-6fa5-4661-9439-cc6b8e04a280	String	jsonType.label
5207cf5b-c0b8-4c94-bed3-47868acfc1ad	true	userinfo.token.claim
5207cf5b-c0b8-4c94-bed3-47868acfc1ad	firstName	user.attribute
5207cf5b-c0b8-4c94-bed3-47868acfc1ad	true	id.token.claim
5207cf5b-c0b8-4c94-bed3-47868acfc1ad	true	access.token.claim
5207cf5b-c0b8-4c94-bed3-47868acfc1ad	given_name	claim.name
5207cf5b-c0b8-4c94-bed3-47868acfc1ad	String	jsonType.label
db9db369-59d7-46cb-a865-c4b95941c096	true	userinfo.token.claim
db9db369-59d7-46cb-a865-c4b95941c096	middleName	user.attribute
db9db369-59d7-46cb-a865-c4b95941c096	true	id.token.claim
db9db369-59d7-46cb-a865-c4b95941c096	true	access.token.claim
db9db369-59d7-46cb-a865-c4b95941c096	middle_name	claim.name
db9db369-59d7-46cb-a865-c4b95941c096	String	jsonType.label
468554e0-0287-4218-ae76-f59c58c3d4da	true	userinfo.token.claim
468554e0-0287-4218-ae76-f59c58c3d4da	nickname	user.attribute
468554e0-0287-4218-ae76-f59c58c3d4da	true	id.token.claim
468554e0-0287-4218-ae76-f59c58c3d4da	true	access.token.claim
468554e0-0287-4218-ae76-f59c58c3d4da	nickname	claim.name
468554e0-0287-4218-ae76-f59c58c3d4da	String	jsonType.label
11a06d38-d5e4-4ff6-9702-097fc9f367d0	true	userinfo.token.claim
11a06d38-d5e4-4ff6-9702-097fc9f367d0	username	user.attribute
11a06d38-d5e4-4ff6-9702-097fc9f367d0	true	id.token.claim
11a06d38-d5e4-4ff6-9702-097fc9f367d0	true	access.token.claim
11a06d38-d5e4-4ff6-9702-097fc9f367d0	preferred_username	claim.name
11a06d38-d5e4-4ff6-9702-097fc9f367d0	String	jsonType.label
5dacb5cf-debd-42af-a249-316f22c48ed9	true	userinfo.token.claim
5dacb5cf-debd-42af-a249-316f22c48ed9	profile	user.attribute
5dacb5cf-debd-42af-a249-316f22c48ed9	true	id.token.claim
5dacb5cf-debd-42af-a249-316f22c48ed9	true	access.token.claim
5dacb5cf-debd-42af-a249-316f22c48ed9	profile	claim.name
5dacb5cf-debd-42af-a249-316f22c48ed9	String	jsonType.label
26c9c69f-462f-4c34-8b77-8559c9b9e334	true	userinfo.token.claim
26c9c69f-462f-4c34-8b77-8559c9b9e334	picture	user.attribute
26c9c69f-462f-4c34-8b77-8559c9b9e334	true	id.token.claim
26c9c69f-462f-4c34-8b77-8559c9b9e334	true	access.token.claim
26c9c69f-462f-4c34-8b77-8559c9b9e334	picture	claim.name
26c9c69f-462f-4c34-8b77-8559c9b9e334	String	jsonType.label
bb61fc65-2cd4-42cb-8553-ff162d3e64fe	true	userinfo.token.claim
bb61fc65-2cd4-42cb-8553-ff162d3e64fe	website	user.attribute
bb61fc65-2cd4-42cb-8553-ff162d3e64fe	true	id.token.claim
bb61fc65-2cd4-42cb-8553-ff162d3e64fe	true	access.token.claim
bb61fc65-2cd4-42cb-8553-ff162d3e64fe	website	claim.name
bb61fc65-2cd4-42cb-8553-ff162d3e64fe	String	jsonType.label
9fd8ed24-9692-4395-99d0-f0869ff7c40b	true	userinfo.token.claim
9fd8ed24-9692-4395-99d0-f0869ff7c40b	gender	user.attribute
9fd8ed24-9692-4395-99d0-f0869ff7c40b	true	id.token.claim
9fd8ed24-9692-4395-99d0-f0869ff7c40b	true	access.token.claim
9fd8ed24-9692-4395-99d0-f0869ff7c40b	gender	claim.name
9fd8ed24-9692-4395-99d0-f0869ff7c40b	String	jsonType.label
9f1d6790-020c-460d-831b-836d2023944a	true	userinfo.token.claim
9f1d6790-020c-460d-831b-836d2023944a	birthdate	user.attribute
9f1d6790-020c-460d-831b-836d2023944a	true	id.token.claim
9f1d6790-020c-460d-831b-836d2023944a	true	access.token.claim
9f1d6790-020c-460d-831b-836d2023944a	birthdate	claim.name
9f1d6790-020c-460d-831b-836d2023944a	String	jsonType.label
ffa07e3c-699c-4adc-8488-fd8f1740381d	true	userinfo.token.claim
ffa07e3c-699c-4adc-8488-fd8f1740381d	zoneinfo	user.attribute
ffa07e3c-699c-4adc-8488-fd8f1740381d	true	id.token.claim
ffa07e3c-699c-4adc-8488-fd8f1740381d	true	access.token.claim
ffa07e3c-699c-4adc-8488-fd8f1740381d	zoneinfo	claim.name
ffa07e3c-699c-4adc-8488-fd8f1740381d	String	jsonType.label
4bef9b50-bfe5-4cf0-82af-f7f842608734	true	userinfo.token.claim
4bef9b50-bfe5-4cf0-82af-f7f842608734	locale	user.attribute
4bef9b50-bfe5-4cf0-82af-f7f842608734	true	id.token.claim
4bef9b50-bfe5-4cf0-82af-f7f842608734	true	access.token.claim
4bef9b50-bfe5-4cf0-82af-f7f842608734	locale	claim.name
4bef9b50-bfe5-4cf0-82af-f7f842608734	String	jsonType.label
89a131f6-f732-4d2d-b809-e5c19f444317	true	userinfo.token.claim
89a131f6-f732-4d2d-b809-e5c19f444317	updatedAt	user.attribute
89a131f6-f732-4d2d-b809-e5c19f444317	true	id.token.claim
89a131f6-f732-4d2d-b809-e5c19f444317	true	access.token.claim
89a131f6-f732-4d2d-b809-e5c19f444317	updated_at	claim.name
89a131f6-f732-4d2d-b809-e5c19f444317	String	jsonType.label
306799bc-75a8-4e82-9170-50a59bd4ba50	true	userinfo.token.claim
306799bc-75a8-4e82-9170-50a59bd4ba50	email	user.attribute
306799bc-75a8-4e82-9170-50a59bd4ba50	true	id.token.claim
306799bc-75a8-4e82-9170-50a59bd4ba50	true	access.token.claim
306799bc-75a8-4e82-9170-50a59bd4ba50	email	claim.name
306799bc-75a8-4e82-9170-50a59bd4ba50	String	jsonType.label
d34ca088-d676-4173-8fe7-61e0dca5c13d	true	userinfo.token.claim
d34ca088-d676-4173-8fe7-61e0dca5c13d	emailVerified	user.attribute
d34ca088-d676-4173-8fe7-61e0dca5c13d	true	id.token.claim
d34ca088-d676-4173-8fe7-61e0dca5c13d	true	access.token.claim
d34ca088-d676-4173-8fe7-61e0dca5c13d	email_verified	claim.name
d34ca088-d676-4173-8fe7-61e0dca5c13d	boolean	jsonType.label
63716c97-c03a-42a6-94c6-127953a9598d	formatted	user.attribute.formatted
63716c97-c03a-42a6-94c6-127953a9598d	country	user.attribute.country
63716c97-c03a-42a6-94c6-127953a9598d	postal_code	user.attribute.postal_code
63716c97-c03a-42a6-94c6-127953a9598d	true	userinfo.token.claim
63716c97-c03a-42a6-94c6-127953a9598d	street	user.attribute.street
63716c97-c03a-42a6-94c6-127953a9598d	true	id.token.claim
63716c97-c03a-42a6-94c6-127953a9598d	region	user.attribute.region
63716c97-c03a-42a6-94c6-127953a9598d	true	access.token.claim
63716c97-c03a-42a6-94c6-127953a9598d	locality	user.attribute.locality
7ea7c153-d4ca-4f5a-8c49-840aaf6b8292	true	userinfo.token.claim
7ea7c153-d4ca-4f5a-8c49-840aaf6b8292	phoneNumber	user.attribute
7ea7c153-d4ca-4f5a-8c49-840aaf6b8292	true	id.token.claim
7ea7c153-d4ca-4f5a-8c49-840aaf6b8292	true	access.token.claim
7ea7c153-d4ca-4f5a-8c49-840aaf6b8292	phone_number	claim.name
7ea7c153-d4ca-4f5a-8c49-840aaf6b8292	String	jsonType.label
947485b5-3dd7-4e3b-90ea-e247cae5e27c	true	userinfo.token.claim
947485b5-3dd7-4e3b-90ea-e247cae5e27c	phoneNumberVerified	user.attribute
947485b5-3dd7-4e3b-90ea-e247cae5e27c	true	id.token.claim
947485b5-3dd7-4e3b-90ea-e247cae5e27c	true	access.token.claim
947485b5-3dd7-4e3b-90ea-e247cae5e27c	phone_number_verified	claim.name
947485b5-3dd7-4e3b-90ea-e247cae5e27c	boolean	jsonType.label
6640d928-5f26-4fa4-913d-b85517aa83d3	true	multivalued
6640d928-5f26-4fa4-913d-b85517aa83d3	foo	user.attribute
6640d928-5f26-4fa4-913d-b85517aa83d3	true	access.token.claim
6640d928-5f26-4fa4-913d-b85517aa83d3	realm_access.roles	claim.name
6640d928-5f26-4fa4-913d-b85517aa83d3	String	jsonType.label
3c1d6054-08e9-4e74-9bf9-5794757c1b3b	true	multivalued
3c1d6054-08e9-4e74-9bf9-5794757c1b3b	foo	user.attribute
3c1d6054-08e9-4e74-9bf9-5794757c1b3b	true	access.token.claim
3c1d6054-08e9-4e74-9bf9-5794757c1b3b	resource_access.${client_id}.roles	claim.name
3c1d6054-08e9-4e74-9bf9-5794757c1b3b	String	jsonType.label
5ae71840-5e71-492d-8a30-867ed186e312	true	userinfo.token.claim
5ae71840-5e71-492d-8a30-867ed186e312	username	user.attribute
5ae71840-5e71-492d-8a30-867ed186e312	true	id.token.claim
5ae71840-5e71-492d-8a30-867ed186e312	true	access.token.claim
5ae71840-5e71-492d-8a30-867ed186e312	upn	claim.name
5ae71840-5e71-492d-8a30-867ed186e312	String	jsonType.label
633d4992-91f4-432a-a78a-0a26085b19dd	true	multivalued
633d4992-91f4-432a-a78a-0a26085b19dd	foo	user.attribute
633d4992-91f4-432a-a78a-0a26085b19dd	true	id.token.claim
633d4992-91f4-432a-a78a-0a26085b19dd	true	access.token.claim
633d4992-91f4-432a-a78a-0a26085b19dd	groups	claim.name
633d4992-91f4-432a-a78a-0a26085b19dd	String	jsonType.label
50890e10-ba22-4b12-8eab-0fcb940cdb68	true	userinfo.token.claim
50890e10-ba22-4b12-8eab-0fcb940cdb68	locale	user.attribute
50890e10-ba22-4b12-8eab-0fcb940cdb68	true	id.token.claim
50890e10-ba22-4b12-8eab-0fcb940cdb68	true	access.token.claim
50890e10-ba22-4b12-8eab-0fcb940cdb68	locale	claim.name
50890e10-ba22-4b12-8eab-0fcb940cdb68	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
react-marathon	60	300	300	\N	\N	\N	t	f	0	keycloak	react-marathon	0	\N	f	f	f	f	NONE	1800	36000	f	f	355b9a2d-edda-4f5c-bd91-7a7e59db4f68	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	9d853247-9bf0-4821-a737-71b470130d3d	54b20568-ad9b-4006-a25f-057a4cb74ccb	10992e1a-960e-4991-b715-4767ce0758e3	54b147fe-5ff0-46fa-93db-d0f5c8b67cef	eb8163a8-a3b0-4bed-8399-bd7cfe1e0d81	2592000	f	900	t	f	38340817-d726-46fa-b970-beb6cb616496	0	f	0	0	08c3b01c-f2b9-400a-932b-8aa54d076168
master	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	6a8e5601-519e-43be-9442-3db44e3a095d	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	19ecbefd-67ac-4f96-bf4e-1d443ac35b0a	d4ddc695-3f86-4806-959e-1fb1ebb72540	be4ed342-4806-499d-a3ca-c0e919e13ec1	20abdda5-23b6-49e7-b713-5f6ddbccca9d	b6e84c6b-8437-4106-a2c6-915ffc0bd034	2592000	f	900	t	f	1e1a249f-d3b3-4680-9016-3c2467468e8b	0	f	0	0	c63f674f-7046-468b-80cb-2ce724540674
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	master	
_browser_header.xContentTypeOptions	master	nosniff
_browser_header.xRobotsTag	master	none
_browser_header.xFrameOptions	master	SAMEORIGIN
_browser_header.contentSecurityPolicy	master	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	master	1; mode=block
_browser_header.strictTransportSecurity	master	max-age=31536000; includeSubDomains
bruteForceProtected	master	false
permanentLockout	master	false
maxFailureWaitSeconds	master	900
minimumQuickLoginWaitSeconds	master	60
waitIncrementSeconds	master	60
quickLoginCheckMilliSeconds	master	1000
maxDeltaTimeSeconds	master	43200
failureFactor	master	30
displayName	master	Keycloak
displayNameHtml	master	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	master	RS256
offlineSessionMaxLifespanEnabled	master	false
offlineSessionMaxLifespan	master	5184000
bruteForceProtected	react-marathon	false
permanentLockout	react-marathon	false
maxFailureWaitSeconds	react-marathon	900
minimumQuickLoginWaitSeconds	react-marathon	60
waitIncrementSeconds	react-marathon	60
quickLoginCheckMilliSeconds	react-marathon	1000
maxDeltaTimeSeconds	react-marathon	43200
failureFactor	react-marathon	30
actionTokenGeneratedByAdminLifespan	react-marathon	43200
actionTokenGeneratedByUserLifespan	react-marathon	300
defaultSignatureAlgorithm	react-marathon	RS256
offlineSessionMaxLifespanEnabled	react-marathon	false
offlineSessionMaxLifespan	react-marathon	5184000
webAuthnPolicyRpEntityName	react-marathon	keycloak
webAuthnPolicySignatureAlgorithms	react-marathon	ES256
webAuthnPolicyRpId	react-marathon	
webAuthnPolicyAttestationConveyancePreference	react-marathon	not specified
webAuthnPolicyAuthenticatorAttachment	react-marathon	not specified
webAuthnPolicyRequireResidentKey	react-marathon	not specified
webAuthnPolicyUserVerificationRequirement	react-marathon	not specified
oauth2DeviceCodeLifespan	react-marathon	600
oauth2DevicePollingInterval	react-marathon	5
webAuthnPolicyCreateTimeout	react-marathon	0
webAuthnPolicyAvoidSameAuthenticatorRegister	react-marathon	false
webAuthnPolicyRpEntityNamePasswordless	react-marathon	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	react-marathon	ES256
webAuthnPolicyRpIdPasswordless	react-marathon	
webAuthnPolicyAttestationConveyancePreferencePasswordless	react-marathon	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	react-marathon	not specified
webAuthnPolicyRequireResidentKeyPasswordless	react-marathon	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	react-marathon	not specified
webAuthnPolicyCreateTimeoutPasswordless	react-marathon	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	react-marathon	false
client-policies.profiles	react-marathon	{"profiles":[]}
client-policies.policies	react-marathon	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	react-marathon	
_browser_header.xContentTypeOptions	react-marathon	nosniff
_browser_header.xRobotsTag	react-marathon	none
_browser_header.xFrameOptions	react-marathon	SAMEORIGIN
_browser_header.contentSecurityPolicy	react-marathon	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
cibaBackchannelTokenDeliveryMode	react-marathon	poll
cibaExpiresIn	react-marathon	120
cibaInterval	react-marathon	5
cibaAuthRequestedUserHint	react-marathon	login_hint
parRequestUriLifespan	react-marathon	60
_browser_header.xXSSProtection	react-marathon	1; mode=block
_browser_header.strictTransportSecurity	react-marathon	max-age=31536000; includeSubDomains
clientSessionIdleTimeout	react-marathon	0
clientSessionMaxLifespan	react-marathon	0
clientOfflineSessionIdleTimeout	react-marathon	0
clientOfflineSessionMaxLifespan	react-marathon	0
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
master	jboss-logging
react-marathon	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	master
password	password	t	t	react-marathon
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
react-marathon	
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.redirect_uris (client_id, value) FROM stdin;
4d63cc93-ee21-4b8e-93e0-6b0db0612efa	/realms/master/account/*
e8a8e7cc-5170-46b8-a979-86b100349a5e	/realms/master/account/*
5d8d60cd-2275-4624-a83b-0cc2489052df	/admin/master/console/*
72c97257-a124-4449-b005-541f7c4a3f47	/realms/react-marathon/account/*
d0ac1d0b-848b-4beb-8203-7c7ac2ec867b	/realms/react-marathon/account/*
9a237619-9551-42d8-93d6-2382c2236bd5	/admin/react-marathon/console/*
4e126d73-3f63-4b81-9d4c-5ceed8e8b535	http://localhost:3000/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
d41204f5-39d8-407a-9158-34c684b6af2d	VERIFY_EMAIL	Verify Email	master	t	f	VERIFY_EMAIL	50
bfce96fc-bd29-4079-bf68-e1fca38fd71b	UPDATE_PROFILE	Update Profile	master	t	f	UPDATE_PROFILE	40
0f033a42-f6f3-47ca-9f95-837a52b67b90	CONFIGURE_TOTP	Configure OTP	master	t	f	CONFIGURE_TOTP	10
744c980e-38f7-421b-835d-c856135d7d40	UPDATE_PASSWORD	Update Password	master	t	f	UPDATE_PASSWORD	30
e02cb27d-2da5-4c4a-8d0e-6cfa5ceaad89	terms_and_conditions	Terms and Conditions	master	f	f	terms_and_conditions	20
5cd34d80-33e0-431c-8724-7e642880590d	update_user_locale	Update User Locale	master	t	f	update_user_locale	1000
1b5eb893-98a8-43f9-840f-3a32bdf4e897	delete_account	Delete Account	master	f	f	delete_account	60
f9e57953-2419-4b1e-9dd3-1694917209f2	VERIFY_EMAIL	Verify Email	react-marathon	t	f	VERIFY_EMAIL	50
76e7e475-cd5c-4c6c-81da-12a5cb107000	UPDATE_PROFILE	Update Profile	react-marathon	t	f	UPDATE_PROFILE	40
9df2b06b-3e1c-468a-943b-510e89facb76	CONFIGURE_TOTP	Configure OTP	react-marathon	t	f	CONFIGURE_TOTP	10
0ea84c81-d736-4173-b08c-745f61af3b36	UPDATE_PASSWORD	Update Password	react-marathon	t	f	UPDATE_PASSWORD	30
3900212d-f5d6-4231-bb0f-0a3ba24e1113	terms_and_conditions	Terms and Conditions	react-marathon	f	f	terms_and_conditions	20
a713057a-7960-4515-8ff4-2775c4835d4d	update_user_locale	Update User Locale	react-marathon	t	f	update_user_locale	1000
387fa773-ca7d-473c-b8fc-1ffe39d3310a	delete_account	Delete Account	react-marathon	f	f	delete_account	60
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
e8a8e7cc-5170-46b8-a979-86b100349a5e	a7a0cf19-fff5-4693-93fb-7c7d6ca37f30
d0ac1d0b-848b-4beb-8203-7c7ac2ec867b	f8cd713c-e194-4ba4-b08f-1ca0b0e9a612
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
ff4a6f5a-25b1-45f0-9682-7b24284ea644	\N	335e5737-2913-461b-ab27-c5004913acc2	f	t	\N	\N	\N	master	admin	1634367340730	\N	0
fda8950c-ee46-4236-81f8-8b93908aa302	\N	ff8607af-a8fe-4b1e-a7f2-500d35ffb9b7	f	t	\N	\N	\N	react-marathon	ku3mi41	1634368274850	\N	0
21ce4760-0f9d-4885-8b24-5b013838c11d	\N	91a7dd04-48e2-401a-8bc1-9f4b1bbfe3af	f	t	\N	\N	\N	react-marathon	demo1	1634478170926	\N	0
ec357381-e333-4868-9941-1f01b3c5d596	\N	8227092f-c0f6-4954-9445-24466cf53d22	f	t	\N	\N	\N	react-marathon	demo2	1634478198046	\N	0
d5c06209-b65e-4d2c-8859-d4e66795505d	\N	c86a6777-0974-485e-a956-14e11e467fc4	f	t	\N	\N	\N	react-marathon	demo3	1634478215276	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
c63f674f-7046-468b-80cb-2ce724540674	ff4a6f5a-25b1-45f0-9682-7b24284ea644
7ab49848-9cb9-4c00-b817-75b2f4e143e3	ff4a6f5a-25b1-45f0-9682-7b24284ea644
08c3b01c-f2b9-400a-932b-8aa54d076168	fda8950c-ee46-4236-81f8-8b93908aa302
08c3b01c-f2b9-400a-932b-8aa54d076168	21ce4760-0f9d-4885-8b24-5b013838c11d
08c3b01c-f2b9-400a-932b-8aa54d076168	ec357381-e333-4868-9941-1f01b3c5d596
08c3b01c-f2b9-400a-932b-8aa54d076168	d5c06209-b65e-4d2c-8859-d4e66795505d
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: dnedtjrx
--

COPY public.web_origins (client_id, value) FROM stdin;
5d8d60cd-2275-4624-a83b-0cc2489052df	+
9a237619-9551-42d8-93d6-2382c2236bd5	+
4e126d73-3f63-4b81-9d4c-5ceed8e8b535	http://localhost:3000
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: dnedtjrx
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: dnedtjrx
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0 (Debian 14.0-1.pgdg110+1)
-- Dumped by pg_dump version 14.0 (Debian 14.0-1.pgdg110+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: dnedtjrx
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO dnedtjrx;

\connect postgres

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: dnedtjrx
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

