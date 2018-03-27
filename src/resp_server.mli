module type DATA = sig
  type t
end

module type AUTH = sig
  type t
  val check: t -> string array -> bool
end

module type SERVER = sig
  module Auth: AUTH
  module Data: DATA

  type t

  val create :
    ?auth:Auth.t ->
    ?host:string ->
    ?tls_config:Conduit_lwt_unix.tls_server_key ->
    Conduit_lwt_unix.server ->
    Data.t ->
    t Lwt.t

  val run :
    ?backlog:int ->
    ?timeout:int ->
    ?stop:unit Lwt.t ->
    ?on_exn:(exn -> unit) ->
    t ->
    (Data.t -> string -> Hiredis.value array -> Hiredis.value option Lwt.t) ->
    unit Lwt.t
end

module Auth: sig
  module String: AUTH
end

module Make(A: AUTH)(D: DATA) : SERVER with module Data = D and module Auth = A
