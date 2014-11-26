function extractEmails(text)
{
	// WILL RETURN AN ARRAY OF EMAIL ID's
    return text.match(/([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9._-]+)/gi);
}