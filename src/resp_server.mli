module type BACKEND = sig
  type t
  type auth

  val auth: auth option -> string array -> bool
end

module type SERVER = sig
  module Backend: BACKEND

  type t

  val create :
    ?auth:Backend.auth ->
    ?host:string ->
    ?tls_config:Conduit_lwt_unix.tls_server_key ->
    Conduit_lwt_unix.server ->
    Backend.t ->
    t Lwt.t

  val run :
    ?backlog:int ->
    ?timeout:int ->
    ?stop:unit Lwt.t ->
    ?on_exn:(exn -> unit) ->
    t ->
    (Backend.t -> Hiredis.value array -> Hiredis.value option Lwt.t) ->
    unit Lwt.t
end

module Make(B: BACKEND) : SERVER with module Backend = B
