open Lwt.Infix

module Unit = struct
  type t = unit
end

module Server = Resp_server.Make(Unit)

let main =
    Server.create (`TCP (`Port 1234)) () >>= fun server ->
    Server.run server (fun () args ->
        Lwt.return_some (Hiredis.Value.int 9999))

let _ = Lwt_main.run main
