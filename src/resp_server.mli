(** The BACKEND module type defines the minimum needed interface to
 * create a new RESP server *)
module type BACKEND = sig

  (** t is the server request context type *)
  type t

  (** client is the client context type *)
  type client

  (** new_client creates new client context *)
  val new_client: t -> client
end

(** The AUTH module type defines the interface for authenticating a client *)
module type AUTH = sig

  (** Authentication type *)
  type t

  (** check is used to determine if the client has passed the correct
   *  authentication to the server *)
  val check: t -> string array -> bool
end

module type SERVER = sig
  module Auth: AUTH
  module Backend: BACKEND

  type t

  type command =
    Backend.t ->
    Backend.client ->
    string ->
    Hiredis.value array ->
    Hiredis.value option Lwt.t

  val add_command: t -> string -> command -> unit
  val del_command: t -> string -> unit
  val get_command: t -> string -> command option

  val create :
    ?auth: Auth.t ->
    ?default: command ->
    ?commands: (string * command) list ->
    ?host: string ->
    ?tls_config: Conduit_lwt_unix.tls_server_key ->
    Conduit_lwt_unix.server ->
    Backend.t ->
    t Lwt.t

  val run :
    ?backlog: int ->
    ?timeout: int ->
    ?stop: unit Lwt.t ->
    ?on_exn: (exn -> unit) ->
    t ->
    unit Lwt.t
end

module Auth: sig
  module String: AUTH
end

module Make(A: AUTH)(D: BACKEND): SERVER with module Backend = D and module Auth = A
