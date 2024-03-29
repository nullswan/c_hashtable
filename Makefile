# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: c3b5aw <dev@c3b5aw.dev>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/07/18 04:24:34 by c3b5aw            #+#    #+#              #
#    Updated: 2021/07/18 07:42:58 by c3b5aw           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME		= lhashtable.a
PREFIX_MSG 	= "[LIB-HASHTABLE]"
SRCS 		= bucket_methods.c buckets.c \
			collision_chains.c handler.c \
			hash.c item.c \
			table.c utils.c
TEST_SRCS 	= tests/adv_tests.c tests/main.c tests/basic_tests.c \
			tests/find_tests.c tests/utils.c

CC		= clang
LINKER	= ar -rcs

SRCS_DIR	 = srcs
OBJS_DIR	 = objs
INCLUDES_DIR = includes
OBJS		 = $(addprefix objs/, $(SRCS:.c=.o))

NAME_TEST	= tests_bin

CFLAGS		= -Wall -Wextra -Werror -g3
CSANITIZE	= -g -fsanitize=address
PRINTER		= printf

RM			= /bin/rm -f

CMP_MSG		= "$(PREFIX_MSG)[\\033[33m\+\\033[0m]"
INF_MSG		= "$(PREFIX_MSG)[\\033[37mINF\\033[0m]"
SCS_MSG		= "$(PREFIX_MSG)[\\033[32mSUC\\033[0m]"

objs/%.o	: srcs/%.c
			@	mkdir -p $(dir $@)
			@	$(PRINTER) "$(CMP_MSG) Compiling $<\n"
			@	$(CC) $(CFLAGS) -c $< -o $@
all		:	$(NAME)
$(NAME)	: 	$(OBJS)
		@	$(LINKER) $@ $^
		@	$(PRINTER) "$(SCS_MSG) $(NAME) @ built !\n"

re		:	fclean all
fclean	:	clean
		@	$(RM) $(NAME)
		@	$(RM) $(NAME_TEST)
clean	:
		@	$(PRINTER) "$(INF_MSG) Deleting assets...\n"
		@	$(RM) -r $(OBJS_DIR)

tests: re
		@	$(CC) $(CFLAGS) $(TEST_SRCS)  -I includes $(NAME) -o $(NAME_TEST)
		@	./tests/tester.sh

.PHONY	:	fclean clean re all
