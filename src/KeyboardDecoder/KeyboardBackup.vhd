  -- curposX
  -- update cursor X position based on current cursor position (curposX and curposY) and cursor
  -- movement (curMovement)
  process(clk)
  begin
    if rising_edge(clk) then
      if rst='1' then
        curposX <= (others => '0');
      elsif (WRstate = WRCHAR) then
        if (curMovement = FORWARD) then
          if (curposX = 19) then
            curposX <= (others => '0');
          else
            curposX <= curposX + 1;
          end if;
        elsif (curMovement = BACKWARD) then
          if ((curposX = 0) and (curposY >= 0)) then
            curposX <= to_unsigned(19, curposX'length);
          else
            curposX <= curposX - 1;
          end if;
        elsif (curMovement = NEWLINE) then
          curposX <= (others => '0');
        end if;
      end if;
    end if;
  end process;
	

  -- curposY
  -- update cursor Y position based on current cursor position (curposX and curposY) and cursor
  -- movement (curMovement)
  process(clk)
  begin
    if rising_edge(clk) then
      if rst='1' then
        curposY <= (others => '0');
      elsif (WRstate = WRCHAR) then
        if (curMovement = FORWARD) then
          if (curposX = 19) then
            if (curposY = 14) then
              curposY <= (others => '0');
            else
              curposY <= curposY + 1;
            end if;
          end if;
        elsif (curMovement = BACKWARD) then
          if (curposX = 0) then
            if (curposY = 0) then
              curposY <= to_unsigned(14, curposY'length);
            else
              curposY <= curposY - 1;
            end if;
          end if;
        elsif (curMovement = NEWLINE) then
          if (curposY = 14) then
            curposY <= (others => '0');
          else
            curposY <= curposY + 1;
          end if;
        end if;
      end if;
    end if;
  end process;


  -- write state
  -- every write cycle begins with writing the character tile index at the current
  -- cursor position, then moving to the next cursor position and there write the
  -- cursor tile index
  process(clk)
  begin
    if rising_edge(clk) then
      if rst='1' then
        WRstate <= STANDBY;
      else
        case WRstate is
          when STANDBY =>
            if (PS2state = MAKE) then
              WRstate <= WRCHAR;
            else
              WRstate <= STANDBY;
            end if;
          when WRCHAR =>
            WRstate <= WRCUR;
          when WRCUR =>
            WRstate <= STANDBY;
          when others =>
            WRstate <= STANDBY;
        end case;
      end if;
    end if;
  end process;
	
