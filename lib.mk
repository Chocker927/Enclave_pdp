UNTRUSTED_DIR=app
PDP_DIR=pdp
PDP_C_Files := $(wildcard $(PDP_DIR)/*.c)
PDP_C_Objects := $(PDP_C_Files:.c=.o)
TARGET=libpdp.a

.PHONY: all

all: libpdp.a

$(PDP_DIR)/%.o: %(PDP_DIR)/%.c
	$(VCC) -c $< -o $@

libpdp.a:$(PDP_C_Objects)
	@rm -f $(UNTRUSTED_DIR)/libpdp.a
	@ar crv $(PDP_DIR)/$(TARGET) $^ 
	@cp $(PDP_DIR)/$(TARGET) $(UNTRUSTED_DIR)/.

clean:
	@rm -f $(PDP_C_Objects) $(PDP_DIR)/$(TARGET)