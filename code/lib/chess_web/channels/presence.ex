defmodule ChessWeb.Presence do
  @moduledoc """
  Fournit un suivi de présence sur les canaux et les processus.

   Voir [`Phoenix.Presence`](http://hexdocs.pm/phoenix/Phoenix.Presence.html)
   docs pour plus de détails.

   ## Utilisation

   Les présences peuvent être suivies dans votre chaîne après avoir rejoint :

       defmodule Chess.MyChannel do
        use ChessWeb, :channel
        alias Chess.Presence

        def join("some:topic", _params, socket) do
          send(self, :after_join)
          {:ok, assign(socket, :user_id, ...)}
        end

        def handle_info(:after_join, socket) do
          push socket, "presence_state", Presence.list(socket)
          {:ok, _} = Presence.track(socket, socket.assigns.user_id, %{
            online_at: inspect(System.system_time(:second))
          })
          {:noreply, socket}
        end
      end

   Dans l'exemple ci-dessus, `Presence.track` est utilisé pour enregistrer ce
   processus du canal en tant que présence pour l'ID utilisateur du socket, avec
   une carte des métadonnées. Ensuite, la liste de présence actuelle pour
   le sujet du socket est transmis au client en tant qu'événement `"presence_state"`.

   Enfin, un diff des événements de présence et de départ sera envoyé au
   client au fur et à mesure qu'ils se produisent en temps réel avec l'événement "presence_diff".
   Voir `Phoenix.Presence.list/2` pour plus de détails sur la structure de données de présence.

   ## Récupération des informations de présence

   Le rappel `fetch/2` est déclenché lors de l'utilisation de `list/1`
   et sert de mécanisme pour récupérer les informations de présence une seule fois,
   avant de diffuser l'information à tous les abonnés de la chaîne.
   Cela évite les problèmes de requête N et vous donne un seul endroit pour regrouper
   récupération de données isolées pour étendre les métadonnées de présence.

   La fonction reçoit un sujet et une carte des présences et doit retourner un
   carte des données correspondant à la structure de données Présence :

       %{"123" => %{metas : [%{status : "away", phx_ref : ...}],
         "456" => %{metas : [%{status : "online", phx_ref : ...}]}

   La clé `:metas` doit être conservée, mais vous pouvez étendre la carte des informations
   pour inclure toute information supplémentaire. Par exemple:

       def fetch(_topic, entries) do
        users = entries |> Map.keys() |> Accounts.get_users_map(entries)
        # => %{"123" => %{name: "User 123"}, "456" => %{name: nil}}

        for {key, %{metas: metas}} <- entries, into: %{} do
          {key, %{metas: metas, user: users[key]}}
        end
      end

   La fonction ci-dessus récupère tous les utilisateurs de la base de données qui
   ont enregistré des présences pour le sujet donné. Le récupéré
   les informations sont ensuite étendues avec une clé `:user` de l'utilisateur
   informations, tout en conservant le champ `:metas` requis de la
   données de présence d'origine.
  """
  use Phoenix.Presence,
    otp_app: :chess,
    pubsub_server: Chess.PubSub
end
