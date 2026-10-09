<?php
/**
 * @package     Joomla.Plugin
 * @subpackage  User.emailname
 */

defined('_JEXEC') or die;

use Joomla\CMS\Plugin\CMSPlugin;
use Joomla\CMS\Factory;
use Joomla\CMS\Application\CMSApplicationInterface;

class PlgUserEmailname extends CMSPlugin
{
    /**
     * Setzt Name & Benutzername vor dem Speichern auf die E-Mail.
     */
    public function onUserBeforeSave($user, $isNew, $data)
    {
        // Nur bei neuer Registrierung
        if (!$isNew) {
            return true;
        }

        if (!empty($data['email'])) {
            $email = trim($data['email']);

            // Name und Benutzername = E-Mail
            $data['name']     = $email;
            $data['username'] = $email;
        }

        return true;
    }

    /**
     * Manipuliert das Registrierungsformular: Felder ausblenden.
     */
    public function onContentPrepareForm($form, $data)
    {
        // Nur das Registrierungsformular bearbeiten
        if ($form->getName() !== 'com_users.registration') {
            return true;
        }

        // Name & Benutzername unsichtbar machen
        if ($form->getField('name')) {
            $form->setFieldAttribute('name', 'type', 'hidden');
        }

        if ($form->getField('username')) {
            $form->setFieldAttribute('username', 'type', 'hidden');
        }

        return true;
    }
}
