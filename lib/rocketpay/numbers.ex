defmodule Rocketpay.Numbers do
  def sum_from_file(filename) do
    "#{filename}.csv"
    # pega o retorno da linha anterior e passa como primeiro argumento para essa
    |> File.read()
    |> handle_file()
  end

  defp handle_file({:ok, result}) do
    result =
      result
      |> String.split(",")
      # o enum executa na hora e o stream é um operador lazy -> só executa qnd precisa do resultado
      # |> Enum.map(fn number -> String.to_integer(number) end)
      |> Stream.map(fn number -> String.to_integer(number) end)
      |> Enum.sum()

    # retorna sempre a última linha
    {:ok, %{result: result}}
  end

  defp handle_file({:error, _reason}), do: {:error, %{message: "Invalid file!"}}
end
