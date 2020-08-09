string_replace( full, find, replace )
{
	if( !isDefined(full) )
		return "";

	if( !isString(full) || !isString(replace) || !isString(find) || find == replace || !isSubStr(full, find) )
		return full;

	return_string = "";
	replacement_count = 0;
	for( m = 0; m < full.size; m++ )
	{
		// Check all characters of a string for a first char match
		n = 0;
		if( full[m] != find[n] )
			continue;

		// Check if the whole find string matches the full's substring
		match = false;
		if( find.size > 1 )
		{
			for( n = 1; n < find.size; n++ )
			{
				if( full[m+n] != find[n] )
				{
					match = false;
					break;
				}
				else
					match = true;
			}
		}
		else
			match = true;

		// If we got a match save its position and start replacing
		if( match )
		{
			first_char = m;
			//rebuild the string before the substring that is going to be replaced
			return_string = "";
			for( r = 0; r < first_char; r++ )
				return_string += full[r];

			//add the replacing string
			return_string += replace;
			
			//rebuild the string after the substing that has been replaced
			find_lenght = find.size;
			for( r = first_char+find_lenght; r < full.size; r++ )
				return_string += full[r];

			//increase replacement count
			replacement_count++;

			//replace the full string so we can check for the next match
			full = return_string;

			//set m to 0 so that it starts the for loop over again
			m = 0;
		}
	}

	if( !replacement_count )
		return full;
	else
		return return_string;
}
