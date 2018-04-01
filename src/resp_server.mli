module type DATA = sig
  type t
  type client
  val new_client: unit -> client
end

module type AUTH = sig
  type t
  val check: t -> string array -> bool
end

module type SERVER = sig
  module Auth: AUTH
  module Data: DATA

  type t

  type command = Data.t -> Data.client -> string -> Hiredis.value array -> Hiredis.value option Lwt.t

  val add_command: t -> string -> command -> unit
  val del_command: t -> string -> unit

  val create :
    ?auth: Auth.t ->
    ?commands: (string * command) list ->
    ?host: string ->
    ?tls_config: Conduit_lwt_unix.tls_server_key ->
    Conduit_lwt_unix.server ->
    Data.t ->
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

module Make(A: AUTH)(D: DATA): SERVER with module Data = D and module Auth = A
