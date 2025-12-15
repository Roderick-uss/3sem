FLAGS = -Wextra -Wall

B_PREFIX = bin/
O_PREFIX = objects/
S_PREFIX = sources/
H_PREFIX = headers/
T_PREFIX = files/

SOURCES_C = client
SOURCES_S = server

OBJECTS_C := $(patsubst %,$(O_PREFIX)%.o,$(SOURCES_C))
OBJECTS_S := $(patsubst %,$(O_PREFIX)%.o,$(SOURCES_S))

HEADER_LIST = $(H_PREFIX)*.h

all: server client

run_server: server
	@./$(B_PREFIX)server

run_client:
	@./$(B_PREFIX)client

server: $(OBJECTS_C)
	@mkdir -p $(B_PREFIX)
	@gcc $(FLAGS) $^ -o $(B_PREFIX)$@

server: $(OBJECTS_S)
	@mkdir -p $(B_PREFIX)
	@gcc $(FLAGS) $^ -o $(B_PREFIX)$@

$(O_PREFIX)%.o: $(S_PREFIX)%.c $(HEADER_LIST)
	@mkdir -p $(O_PREFIX)
	@gcc $(FLAGS) -I $(H_PREFIX) $< -c -o $@

clean:
	rm -rf $(O_PREFIX)*.o $(B_PREFIX)*
