/*
 * Copyright 2025 Jinwoo Sung
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <iostream>
#include <memory>
#include <string>

#include "wirestead/wirestead.hpp"

/**
 * @brief Asynchronous UDS Echo Client Example
 */
int main(int argc, char* argv[]) {
  std::string path = "/tmp/wirestead_echo.sock";
  if (argc > 1) path = argv[1];

  std::cout << "--- Async UDS Echo Client ---\n";
  std::cout << "Connecting to " << path << " (non-blocking)\n";

  std::shared_ptr<wirestead::wrapper::UdsClient> client;

  auto builder = wirestead::uds_client(path);
  builder
      .on_connect([&client](const wirestead::ConnectionContext&) {
        std::cout << "\n[Event] Connected to UDS server!\n"
                  << "> " << std::flush;
        if (client) {
          client->send("Hello UDS!");
        }
      })
      .on_data([](const wirestead::MessageContext& ctx) {
        std::cout << "\n[Received] " << ctx.data() << "\n"
                  << "> " << std::flush;
      })
      .on_disconnect([](const wirestead::ConnectionContext&) {
        std::cout << "\n[Event] Disconnected.\n"
                  << "> " << std::flush;
      })
      .on_error([](const wirestead::ErrorContext& ctx) {
        std::cerr << "\n[Error] " << ctx.message() << "\n"
                  << "> " << std::flush;
      });

  client = builder.build();
  client->start();

  std::cout << "Client started. Type '/quit' to exit.\n\n";

  std::string line;
  while (true) {
    std::cout << "> " << std::flush;
    if (!std::getline(std::cin, line) || line == "/quit") {
      break;
    }

    if (line.empty()) continue;
    client->send(line);
  }

  client->stop();
  return 0;
}
