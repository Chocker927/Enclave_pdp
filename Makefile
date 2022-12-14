#
# Copyright (C) 2011-2017 Intel Corporation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
#   * Redistributions of source code must retain the above copyright
#     notice, this list of conditions and the following disclaimer.
#   * Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in
#     the documentation and/or other materials provided with the
#     distribution.
#   * Neither the name of Intel Corporation nor the names of its
#     contributors may be used to endorse or promote products derived
#     from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#
# include ../buildenv.mk
SGX_SSL := /opt/intel/sgxssl
export PACKAGE_LIB := $(SGX_SSL)/lib64/
export PACKAGE_INC := $(SGX_SSL)/include/
export SGX_SDK ?= /opt/intel/sgxsdk/
export VCC := @$(CC)
export VCXX := @$(CXX)
export OS_ID=0
export LINUX_SGX_BUILD ?= 0

UBUNTU_CONFNAME:=/usr/include/x86_64-linux-gnu/bits/confname.h
ifneq ("$(wildcard $(UBUNTU_CONFNAME))","")
	OS_ID=1
else ifeq ($(origin NIX_STORE),environment)
	OS_ID=3
else
	OS_ID=2
endif

all:speed
	$(MAKE) -f lib.mk all
	$(MAKE) -f sgx_u.mk LINUX_SGX_BUILD=$(LINUX_SGX_BUILD) all
	$(MAKE) -f sgx_t.mk LINUX_SGX_BUILD=$(LINUX_SGX_BUILD) all

test: all
	$(MAKE) -f sgx_u.mk test

clean:cleanspeed
	$(MAKE) -f lib.mk clean
	$(MAKE) -f sgx_u.mk clean
	$(MAKE) -f sgx_t.mk clean

speed:speed.c
	$(VCC) $^ -o $@
	@echo "CC <= speed"

cleanspeed:
	@rm -f testfile/*.tag test speed-tag.log speed-verify.log speed
