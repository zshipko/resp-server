open Lwt.Infix

let main =
    Resp_server.create (`TCP (`Port 1234)) () >>= fun server ->
    Resp_server.run server (fun () args ->
        Lwt.return_some (Hiredis.Value.int 9999))

let _ = Lwt_main.run main
