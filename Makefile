# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jveuille <jveuille@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/29 13:23:39 by jveuille          #+#    #+#              #
#    Updated: 2023/06/29 11:22:20 by jveuille         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = philosopher
PARENT_DIR= $(shell dirname $(shell pwd))
PARENT_NAME= $(shell basename $(PARENT_DIR))
CURRENT_DIR =$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
PROJET_NAME = $(shell basename $(CURRENT_DIR))
#
CC = clang
NORM_EXE= norminette
CFLAGS = -Wall -Wextra -Werror -g3 #-MMD
#	Extra flags to give to compilers when they are supposed to 
#		invoke the linker, ‘ld’, such as -L. Libraries
LDFLAGS = 
# Extra flags to give to compilers when they are supposed to invoke the linker, 
# ‘ld’, such as -L. Libraries
LDLIBS =
#	Library flags or names given to compilers when they are supposed to invoke
#		 the linker, ‘ld’. LOADLIBES is a deprecated (but still supported)
#		 alternative to LDLIBS. Non-library linker flags, such as -L, 
#		should go in the LDFLAGS variable. 
#
ROOT_DIR = ../$(PROJET_NAME)/

LIB_AR=libmy.a
LIBFT_DIR=libft/
LIBFT_AR=libft.a
LIBPF_DIR=ft_printf/
LIBPF_AR=libftprintf.a
LIBGL_DIR=get_next_line/
LIBGL_AR=libftgnl.a

SRC_DIR = srcs/
INC_DIR = includes/
LIB_DIR = lib/
OBJ_DIR = objs/
#BONUS_DIR =
#BUILD_DIR = 

#===================================#
#  Flag for include archive library #
#===================================#

LIBFT= $(ROOT_DIR)$(LIB_DIR)$(LIBFT_DIR)
LIB_FT = $(addprefix $(ROOT_DIR)$(LIB_DIR), $(LIBFT_AR))
FLG_LIBFT= -L $(ROOT_DIR)$(LIB_DIR) -l:$(LIBFT_AR)
#FLG_LIBFT= -L $(ROOT_DIR)$(LIB_DIR) -I$(LIBFT_AR)

LIBPF= $(ROOT_DIR)$(LIB_DIR)$(LIBPF_DIR)
LIB_PF= $(addprefix $(ROOT_DIR)$(LIB_DIR), $(LIBPF_AR))
FLG_LIBPF= -L $(ROOT_DIR)$(LIB_DIR) -l:$(LIBPF_AR)
#FLG_LIBPF= -L $(ROOT_DIR)$(LIB_DIR) -I:$(LIBPF_AR)

LIBGL= $(ROOT_DIR)$(LIB_DIR)$(LIBGL_DIR)
LIB_GL= $(addprefix $(ROOT_DIR)$(LIB_DIR), $(LIBGL_AR))
FLG_LIBGL= -L $(ROOT_DIR)$(LIB_DIR) -l:$(LIBGL_AR)
#FLG_LIBGL= -L $(ROOT_DIR)$(LIB_DIR) -I$(LIBGL_AR)

 
FLG_LIB= $(FLG_LIBMLX) $(FLG_LIBFT) $(FLG_LIBPF)  $(FLG_LIBGL)


#===================================#
#    source directory repository    #
#===================================#

# Only for test , forbidden by norm
#SRCS = $(shell find $(ROOT_DIR)$(SRC_DIR) $(ROOT_DIR)$(INC_DIR) -name '*.c')
#SRCS = $(shell find -path '$(ROOT_DIR)$(SRC_DIR)' -name '*.c')

SRCS_CORE = fdf.c fdf_core.c fdf_mac_core.c fdf_core_loop.c var_utils.c


#prefixing directory names

SRCS_ERRS = $(addprefix error/, $(SRCS_ERR))
SRCS_INITS = $(addprefix init/, $(SRCS_INIT))
SRCS_MEMS = $(addprefix mem/, $(SRCS_MEM))
SRCS_MISCS = $(addprefix misc/, $(SRCS_MISC))


SRCS= $(SRCS_CORE) $(SRCS_ERRS)$(SRCS_INITS) $(SRCS_MEMS) $(SRCS_MISCS)

# listing of all  source subdirectory
SRC_SUB_DIR = $(shell find $(SRC_DIR) -type d)
OBJ_SUB_DIR = $(subst $(SRC_DIR), $(OBJ_DIR), $(SRC_SUB_DIR))

#prefixing directory names with the root of the project name
OBJ_SRCS = $(addprefix $(ROOT_DIR)$(SRC_DIR), $(SRCS))
OBJ_DIRS = $(addprefix $(ROOT_DIR), $(OBJ_DIR))

OBJS =  $(addprefix $(OBJ_DIRS), $(SRCS:.c=.o))

BUILD_ROOT =$(NAME:%=$(ROOT_DIR)$(NAME))
BUILD = $(NAME:%=$(ROOT_DIR)$(BUILD_DIR)$(NAME))

#include .h directory
INC_DIRS := $(shell find $(INC_DIR) -type d )
INC = $(addprefix -I ,$(ROOT_DIR)$(INC_DIRS))

#===================================#
#   Colors for dialogue's cosmetic  #
#===================================#

ifdef TERM
DEF_COLOR = \033[0;39m
GREY = \033[0;90m
RED = \033[0;91m
GREEN = \033[0;92m
YELLOW = \033[0;93m
BLUE = \033[0;94m
MAGENTA = \033[0;95m
CYAN = \033[0;96m
WHITE = \033[0;97m
LWHILE = \033[0;37m
COLRESET = \033[0m
endif

LINKCOLOR=	$(WHITE)
RMCOLOR = $(GREY)
ONNEXT=	$(LWHILE)
MOVELINE =	"\033[1A"
CLEARLINE =	"\033[K"

ITALICON =\033[2m
ITALICOFF =\033[22m
BOLTON =\033[1m
BOLTOFF =\033[21m
ULINEON = \033[4m
ULINEOFF = \033[24m

#===================================#
#              Rules                #
#===================================#
.PHONY: default all bonus clean fclean re


$(NAME): $(OBJS) $(LIB_FT) $(LIB_PF) $(LIB_SPF) $(LIB_GL) $(LIB_MLX)
	@ echo 
	@ echo "$(YELLOW)➼ Creating FDF's executable$(COLRESET)"
	@ echo "LIB_MLX ="$(LIB_MLX)
	@ echo "target	:$(WHITE)$(NAME)$(COLRESET) in $(WHITE)$(ROOT_DIR)$(COLRESET)"
	@ $(CC) $(CFLAGS) $(LDFLAGS) $(LDLIBS) $(FLG_LIB) $(FLG_GPRH) $^  -o $(ROOT_DIR)$@ \
		2>&1 </dev/null && \
		(echo $(CLEARLINE)"$(GREEN)[OK]$(COLRESET)	: "$@ ; (exit 0);) || \
		(echo $(CLEARLINE)"$(RED)[KO]$(COLRESET)	: "$@ ; (exit 1)) 
	
all: lambda $(NAME)

$(OBJ_DIRS)%.o : $(SRC_DIR)%.c
	@ echo "$(ONNEXT)[...]$(COLRESET)	: "$@$(MOVELINE)
	@ if [ ! -d "$(ROOT_DIR)$(OBJ_DIR)" ]; then \
		mkdir -p $(ROOT_DIR)$(OBJ_DIR) 2>&1 </dev/null && \
			echo "$(WHITE)[CREATE]$(COLRESET)	:" $(ROOT_DIR)$(OBJ_DIR); (exit 0); \
		mkdir -p $(ROOT_DIR)$(OBJ_SUB_DIR)  2>&1 </dev/null && \
			echo "$(WHITE)[CREATE]$(COLRESET)	:" $(ROOT_DIR)$(OBJ_SUB_DIR); (exit 0); \
	fi
	@ $(CC) $(CFLAGS) $(LDFLAGS) $(LDLIBS) $(INC) -c $^ -o $@ 2>&1 </dev/null && \
		(echo $(CLEARLINE)"$(GREEN)[OK]$(COLRESET)	: "$@ ; (exit 0);) || \
		(echo $(CLEARLINE)"$(RED)[KO]$(COLRESET)	: "$@ ; (exit 1)) 

$(LIB_FT):
	@ echo 
	@ echo "$(YELLOW)➼ Generate library$(COLRESET)"
	@ echo "target	:$(WHITE)$(LIBFT_AR)$(COLRESET) in $(WHITE)$(LIBFT)$(COLRESET)"
	@ make -C $(LIBFT) all 2>&1 </dev/null && \
		(echo $(CLEARLINE)"$(GREEN)[OK]$(COLRESET)	: "$@ ; (exit 0);) || \
		(echo $(CLEARLINE)"$(RED)[KO]$(COLRESET)	: "$@ ; (exit 1)) 
	@mv $(LIBFT)$(LIBFT_AR) $(ROOT_DIR)$(LIB_DIR)

$(LIB_PF):
	@ echo 
	@ echo "$(YELLOW)➼ Generate library$(COLRESET)"
	@ echo "target	:$(WHITE)$(LIBPF_AR)$(COLRESET) in $(WHITE)$(LIBPF)$(COLRESET)"
	@ make -C $(LIBPF) all 2>&1 </dev/null && \
		(echo $(CLEARLINE)"$(GREEN)[OK]$(COLRESET)	: "$@ ; (exit 0);) || \
		(echo $(CLEARLINE)"$(RED)[KO]$(COLRESET)	: "$@ ; (exit 1)) 
	@mv $(LIBPF)$(LIBPF_AR) $(ROOT_DIR)$(LIB_DIR)

$(LIB_GL):
	@ echo  
	@ echo "$(YELLOW)➼ Generate library$(COLRESET)"
	@ echo "target	:$(WHITE)$(LIBGL_AR)$(COLRESET) in $(WHITE)$(LIBGL)$(COLRESET)"
	@ make -C $(LIBGL) all 2>&1 </dev/null && \
		(echo $(CLEARLINE)"$(GREEN)[OK]$(COLRESET)	: "$@ ; (exit 0);) || \
		(echo $(CLEARLINE)"$(RED)[KO]$(COLRESET)	: "$@ ; (exit 1)) 	
	@ mv $(LIBGL)$(LIBGL_AR) $(ROOT_DIR)$(LIB_DIR)


norm: $(OBJ_SRCS) $(INC_DIRS) $(LIBFT) $(LIBPF)
	@ echo "$(YELLOW)➼ Check Norm$(COLRESET)"
	@ echo "target	:$(WHITE)"$(ROOT_DIR)"$(COLRESET)"
	@ if [ ! -f "$(NORM_EXE)" ]; then \
		echo $(CLEARLINE)"$(RED)[KO]	$(WHITE)"$(NORM_EXE)" not found$(COLRESET)"; (exit 1); else \
		echo $(CLEARLINE)"$(GREEN)[OK]	$(WHITE)"$(NORM_EXE)" found$(COLRESET)"; \
		$(NORM_EXE) $^ | \
			(! grep -E -B 1 "(^Warning|^Error)" 2>&1 </dev/null) && \
			echo "$(GREEN)[NORM]$(COLRESET)	: pass" || \
			(echo "$(RED)[NORM]$(COLRESET)	: failed "); (exit 0); \
	fi

lambda:
	@ echo "$(YELLOW)➼ Compiling $(NAME)'s project$(COLRESET)"


clean:
	@ echo "$(YELLOW)➼ Remove objects$(COLRESET)"
	@ rm -f $(OBJS) $(LIBFT)*.o $(LIBPF)*.o  $(LIBGL)*.o $(LIBMLX)*.o 2>&1 </dev/null && \
		echo "$(RMCOLOR)[DEL]$(COLRESET)	:" obj ; (exit 0)
	@ if [  -d "$(ROOT_DIR)$(OBJ_DIR)" ]; then \
		rm -r $(OBJ_DIR) 2>&1 </dev/null && \
			echo "$(RMCOLOR)[DEL]$(COLRESET)	:" dep ; (exit 0); \
	fi
	@ echo 

fclean: clean
	@ echo "$(YELLOW)➼ Remove librarys$(COLRESET)"
	@ rm -f $(NAME)  2>&1 </dev/null && \
		echo "$(RMCOLOR)[DEL]$(COLRESET)	:" $(NAME) ; (exit 0);
	@ rm -f $(LIB_DIR)$(LIBFT_AR) 2>&1 </dev/null && \
		echo "$(RMCOLOR)[DEL]$(COLRESET)	:" $(LIB_DIR)$(LIBFT_AR) ; (exit 0)
	@ rm -f $(LIB_DIR)$(LIBPF_AR) 2>&1 </dev/null && \
		echo "$(RMCOLOR)[DEL]$(COLRESET)	:" $(LIB_DIR)$(LIBPF_AR) ; (exit 0)
	@ rm -f $(LIB_DIR)$(LIBGL_AR) 2>&1 </dev/null && \
		echo "$(RMCOLOR)[DEL]$(COLRESET)	:" $(LIB_DIR)$(LIBGL_AR) ; (exit 0)
	@ echo 

re: fclean all
