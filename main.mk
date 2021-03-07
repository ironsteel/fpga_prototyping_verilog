YOSYS           ?= yosys
NEXTPNR-ICE40   ?= nextpnr-ice40

all: ${PROJ}.bin ${PROJ}.json

%.json: ${VERILOG_FILES}
	$(YOSYS) -q -l synth.log \
	-p "read_verilog ${VERILOG_FILES}" \
	-p "hierarchy -top top" \
	-p "synth_ice40 ${YOSYS_OPTIONS} -json $@"

%.asc: $(PIN_DEF) %.json
	$(NEXTPNR-ICE40) $(NEXTPNR_OPTIONS) --json  $(filter-out $<,$^) --up5k $(if $(FREQ),--freq $(FREQ)) --package sg48  --pcf $< --asc $@


${PROJ}_tb: ../sim_helpers/assert.v ${PROJ}_tb.v ${VERILOG_FILES}
	iverilog  -DSIM -g2012 -o $@ $^

sim: ${PROJ}_tb
	vvp -N $<

%.bin: %.asc
	icepack $< $@

clean:
	rm -f *.bin *.asc *.json synth.log *_tb *.vcd

.SECONDARY:
.PHONY: all prog clean
