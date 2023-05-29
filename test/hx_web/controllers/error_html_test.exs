defmodule HxWeb.ErrorHTMLTest do
  use HxWeb.ConnCase, async: true

  import Phoenix.Template, only: [render_to_string: 4]

  describe "404" do
    setup %{conn: conn} do
      conn = Plug.Conn.put_status(conn, 404)

      html = render_to_string(HxWeb.ErrorHTML, "404", "html", conn: conn)

      document = Floki.parse_document!(html)

      %{document: document}
    end

    test "title", %{document: document} do
      title =
        document
        |> Floki.find("title")
        |> Floki.text()
        |> String.trim()

      assert "Page not found | Hx" == title
    end

    test "status code", %{document: document} do
      status_code =
        document
        |> Floki.find("#status_code")
        |> Floki.text()
        |> String.trim()

      assert "404" == status_code
    end

    test "status message", %{document: document} do
      status_message =
        document
        |> Floki.find("#status_message")
        |> Floki.text()
        |> String.trim()

      assert "Page not found" == status_message
    end
  end

  describe "500" do
    setup %{conn: conn} do
      conn = Plug.Conn.put_status(conn, 500)

      html = render_to_string(HxWeb.ErrorHTML, "500", "html", conn: conn)

      document = Floki.parse_document!(html)

      %{document: document}
    end

    test "title", %{document: document} do
      title =
        document
        |> Floki.find("title")
        |> Floki.text()
        |> String.trim()

      assert "Internal server error | Hx" == title
    end

    test "status code", %{document: document} do
      status_code =
        document
        |> Floki.find("#status_code")
        |> Floki.text()
        |> String.trim()

      assert "500" == status_code
    end

    test "status message", %{document: document} do
      status_message =
        document
        |> Floki.find("#status_message")
        |> Floki.text()
        |> String.trim()

      assert "Internal server error" == status_message
    end
  end
end
